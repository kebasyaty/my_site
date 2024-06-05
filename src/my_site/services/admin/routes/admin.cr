module Vizbor::Services::Admin::Routes
  # Admin panel page
  get "/admin" do |env|
    env.redirect "/sign-in"
  end

  # Get language code
  get "/language-code" do |env|
    env.redirect "/sign-in"
  end

  # Login page
  get "/sign-in" do |env|
    if env.session.object?("user").nil?
      if Vizbor::Services::Admin::Models::User.estimated_document_count == 0
        # Create first user (administrator)
        first_user = Vizbor::Services::Admin::Models::User.new
        first_user.username.value = "admin"
        first_user.email.value = "no_reply@email.net"
        first_user.password.value = "12345678"
        first_user.confirm_password.value = "12345678"
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
