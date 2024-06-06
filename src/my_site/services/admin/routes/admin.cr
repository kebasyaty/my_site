module Vizbor::Services::Admin::Routes
  # Admin panel page
  get "/admin" do |env|
    env.redirect "/admin/sign-in"
  end

  # Get language code
  get "/admin/language-code" do |env|
    language_code = {
      language_code: Vizbor::Settings.default_locale,
      msg_err:       "",
    }.to_json
    env.response.content_type = "application/json"
    language_code
  end

  # Login page
  get "/admin/sign-in" do |env|
    if env.session.object?("user").nil?
      if Vizbor::Services::Admin::Models::User.estimated_document_count == 0
        # Create first user (administrator)
        first_user = Vizbor::Services::Admin::Models::User.new
        first_user.username.value = "admin"
        first_user.email.value = !Vizbor::Settings.debug? ? "???" : "no_reply@email.net"
        first_user.password.value = !Vizbor::Settings.debug? ? "???" : "12345678"
        first_user.confirm_password.value = !Vizbor::Settings.debug? ? "???" : "12345678"
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
end
