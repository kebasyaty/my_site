module Vizbor::Services::Admin::Routes
  # Admin panel page
  get "/admin" do |env|
    env.redirect "/sign-in"
  end

  # Login page
  get "/sign-in" do
    "Hello Admin!"
  end
end
