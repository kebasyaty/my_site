module Services::Admin::Routes
  # Logout
  post "/admin/logout" do |env|
    env.session.destroy
    env.response.content_type = "application/json"
    "Goodbye!".to_json
  end
end
