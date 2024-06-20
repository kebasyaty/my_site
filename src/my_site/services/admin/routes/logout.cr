module Services::Admin::Routes
  # Logout
  post "/admin/logout" do |env|
    lang_code : String = env.session.string("current_lang")
    auth = Globals::Auth.user_authenticated? env, lang_code
    if auth[:is_authenticated]
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
