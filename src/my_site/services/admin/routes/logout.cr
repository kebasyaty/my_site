module Vizbor::Services::Admin::Routes
  # Logout
  post "/admin/logout" do |env|
    auth = Vizbor::Globals::Auth.user_authenticated? env, is_admin?: true
    if auth[:authenticated?]
      env.session.destroy
    end
    result = {
      is_authenticated: false,
      msg:              "Goodbye!",
    }.to_json
    env.response.content_type = "application/json"
    result
  end
end
