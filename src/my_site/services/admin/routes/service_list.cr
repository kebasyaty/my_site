module Vizbor::Services::Admin::Routes
  # Logout
  post "/admin/service-list" do |env|
    if !env.session.object?("user").nil?
      env.session.destroy
    end
    result = {msg: "Goodbye!"}.to_json
    env.response.content_type = "application/json"
    result
  end
end
