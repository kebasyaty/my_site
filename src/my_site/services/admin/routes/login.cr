module Vizbor::Services::Admin::Routes
  # Login page
  get "/admin/sign-in" do |env|
    if env.session.object?("user").nil?
      if Vizbor::Services::Admin::Models::User.estimated_document_count == 0
        # Create first user (administrator)
        first_user = Vizbor::Services::Admin::Models::User.new
        first_user.username.value = "admin"
        first_user.email.value = if !Vizbor::Settings.debug?
                                   Vizbor::Settings.admin_prod_email
                                 else
                                   "no_reply@email.net"
                                 end
        first_user.password.value = if !Vizbor::Settings.debug?
                                      Vizbor::Settings.admin_prod_pass
                                    else
                                      "12345678"
                                    end
        first_user.confirm_password.value = first_user.password.value
        first_user.is_admin.value = true
        first_user.is_active.value = true

        unless first_user.save
          first_user.print_err
          raise DynFork::Errors::Panic.new(
            "Model : `Vizbor::Services::Admin::Models::User` => " +
            "Error while creating the first user (administrator)."
          )
        end
      end
    end
    send_file env, "views/admin/index.html"
  end

  # Login
  post "/admin/login" do |env|
    authenticated? : Bool = false
    lang_code : String = Vizbor::Settings.default_locale
    username : String = env.params.json["username"].as(String)
    password : String = env.params.json["password"].as(String)

    if !(user = env.session.object?("user")).nil?
      user = user.as(Vizbor::Middleware::Session::UserStorableObject)
      if username == user.username && user.is_admin? && user.is_active?
        authenticated? = true
      end
    else
      # Get user from database
      filter = {username: username, is_admin: true, is_active: true}
      if user = Vizbor::Services::Admin::Models::User.find_one_to_instance(filter)
        # User password verification
        if user.verify_password(password)
          # Update last visit date
          user.last_login.refrash_val_datetime(Time.utc)
          if user.save
            authenticated? = true
          else
            user.print_err
          end
          # Add user details to session
          uso = Vizbor::Middleware::Session::UserStorableObject.new(
            hash: user.hash.value,
            username: user.username.value,
            email: user.email.value,
            is_admin: user.is_admin.value,
            is_active: user.is_active.value,
          )
          env.session.object("user", uso)
        end
      end
    end

    result : String? = nil
    I18n.with_locale(lang_code) do
      result = {
        username:         username,
        is_authenticated: authenticated?,
        msg_err:          authenticated? ? "" : I18n.t(:auth_failed),
      }.to_json
    end
    env.response.content_type = "application/json"
    result
  end
end
