module Vizbor::Services::Admin::Routes
  # Logout
  post "/admin/logout" do |env|
    if !env.session.object?("user").nil?
      env.session.destroy
    end
    result = {msg: "You have been logged out."}.to_json
    env.response.content_type = "application/json"
    result
  end
end
