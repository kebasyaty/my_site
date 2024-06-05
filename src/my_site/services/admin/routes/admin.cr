module Vizbor::Services::Admin::Routes
  # Admin panel page
  get "/admin" do |env|
    env.redirect "/sign-in"
  end

  # Login page
  get "/sign-in" do |env|
    if (user = env.session.object?("user")).nil?
      if Vizbor::Services::Admin::Models::User.estimated_document_count == 0
        # Create first user (administrator)
        first_user = Vizbor::Services::Admin::Models::User.new
        first_user.username.value = "admin"
        first_user.email.value = "no_reply@email.net"
        first_user.password.value = "12345678"
        first_user.confirm_password.value = "12345678"
        first_user.is_admin.value = true
        first_user.is_active.value = true

        first_user.print_err unless first_user.save
      end
    end
  end
end
