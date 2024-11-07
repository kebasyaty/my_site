module Services::Admin::Routes
  # Logout
  post "/admin/logout" do |env|
    env.session.destroy
    result = {is_authenticated: false}.to_json
    env.response.content_type = "application/json"
    result
  end
end
