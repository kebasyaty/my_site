module Vizbor::Services::Admin::Routes
  # Login page
  get "/admin/sign-in" do |env|
    auth = Vizbor::Globals::Auth.user_authenticated? env, is_admin?: true
    if !auth[:authenticated?]
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
    lang_code : String = Vizbor::Settings.default_locale
    auth = Vizbor::Globals::Auth.user_authenticated? env, is_admin?: true
    authenticated? : Bool = auth[:authenticated?]
    # Login form data
    login : String = env.params.json["login"].as(String) # username or email or phone
    password : String = env.params.json["password"].as(String)

    # Check if the user is authenticated?
    unless authenticated?
      auth = Vizbor::Globals::Auth.user_authentication(
        env,
        login: login,
        password: password,
        is_admin?: true,
      )
      authenticated? = auth[:authenticated?]
    end

    result : String? = nil
    I18n.with_locale(lang_code) do
      result = {
        is_authenticated: authenticated?,
        msg_err:          authenticated? ? "" : I18n.t(:auth_failed),
      }.to_json
    end
    env.response.content_type = "application/json"
    result
  end
end
