module Services::Admin::Routes
  # Login page
  get "/admin/sign-in" do |env|
    if Services::Admin::Models::User.estimated_document_count == 0
      # Create first user (administrator)
      first_user = Services::Admin::Models::User.new
      first_user.username.value = "admin"
      first_user.email.value = if !Vizbor::Settings.debug?
                                 Vizbor::Settings.admin_prod_email
                               else
                                 Vizbor::Settings.admin_dev_email
                               end
      first_user.password.value = if !Vizbor::Settings.debug?
                                    Vizbor::Settings.admin_prod_pass
                                  else
                                    Vizbor::Settings.admin_dev_pass
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
    send_file env, "templates/admin/index.html"
  end

  # Login
  post "/admin/login" do |env|
    if env.session.string("csrf") != env.params.json["authenticity_token"].as(String)
      halt env, status_code: 403, response: "Forbidden"
    end
    lang_code = env.params.json["lang_code"].as(String)
    env.session.string("current_lang", lang_code)
    auth = Globals::Auth.user_authenticated? env, lang_code
    authenticated? : Bool = auth[:is_authenticated] && auth[:is_admin]
    msg_err : String = ""

    # Check if the user is authenticated?
    unless authenticated?
      auth = Globals::Auth.user_authentication(
        env,
        lang_code,
        login: env.params.json["login"].as(String), # username or email
        password: env.params.json["password"].as(String),
      )
      authenticated? = auth[:is_authenticated] && auth[:is_admin]
    end

    I18n.with_locale(lang_code) do
      msg_err = I18n.t(:auth_failed) unless authenticated?
    end

    result = {
      is_authenticated: authenticated?,
      msg_err:          msg_err,
    }.to_json
    env.response.content_type = "application/json"
    result
  end
end
