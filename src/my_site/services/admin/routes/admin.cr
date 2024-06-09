module Vizbor::Services::Admin::Routes
  # Admin panel page
  get "/admin" do |env|
    env.redirect "/admin/sign-in"
  end
end
