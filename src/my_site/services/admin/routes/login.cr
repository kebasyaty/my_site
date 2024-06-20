module Services::Admin::Routes
  # Login page
  get "/admin/sign-in" do |env|
    lang_code : String = env.session.string("current_lang")
    auth = Globals::Auth.user_authenticated? env, lang_code
    if !auth[:is_authenticated]
      if Services::Admin::Models::User.estimated_document_count == 0
        # Create first user (administrator)
        first_user = Services::Admin::Models::User.new
        first_user.username.value = "admin"
        first_user.email.value = if !Vizbor::Settings.debug?
                                   # by default for prod
                                   Vizbor::Settings.admin_prod_email
                                 else
                                   # by default for dev
                                   "no_reply@email.net"
                                 end
        first_user.password.value = if !Vizbor::Settings.debug?
                                      # by default for prod
                                      Vizbor::Settings.admin_prod_pass
                                    else
                                      # by default for dev
                                      "12345678"
                                    end
        first_user.confirm_password.value = first_user.password.value
        first_user.is_admin.value = true
        first_user.is_active.value = true

        unless first_user.save
          first_user.print_err
          raise DynFork::Errors::Panic.new(
            "Model : `Services::Admin::Models::User` => " +
            "Error while creating the first user (administrator)."
          )
        end
      end
    end
    send_file env, "templates/admin/index.html"
  end

  # Login
  post "/admin/login" do |env|
    lang_code : String = env.session.string("current_lang")
    auth = Globals::Auth.user_authenticated? env, lang_code
    authenticated? : Bool = auth[:is_authenticated] && auth[:is_admin]

    # Check if the user is authenticated?
    unless authenticated?
      auth = Globals::Auth.user_authentication(
        env,
        login: env.params.json["login"].as(String), # username or email
        password: env.params.json["password"].as(String),
      )
      authenticated? = auth[:is_authenticated] && auth[:is_admin]
    end

    result = {
      is_authenticated: authenticated?,
      msg_err:          authenticated? ? "" : I18n.with_locale(lang_code) { I18n.t(:auth_failed) },
    }.to_json
    env.response.content_type = "application/json"
    result
  end
end
