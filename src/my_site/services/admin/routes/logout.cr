module Vizbor::Services::Admin::Routes
  # Logout
  post "/admin/logout" do |env|
    if !env.session.object?("user").nil?
      # ...
    end
    result = {msg: "Goodbye!"}.to_json
    env.response.content_type = "application/json"
    result
  end
end
