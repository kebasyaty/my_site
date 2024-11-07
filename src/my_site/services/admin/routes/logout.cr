module Services::Admin::Routes
  # Logout
  post "/admin/logout" do |env|
    lang_code : String = env.session.string("current_lang")
    env.session.destroy
    env.session.string("current_lang", lang_code)
    env.response.content_type = "application/json"
    "Goodbye!".to_json
  end
end
