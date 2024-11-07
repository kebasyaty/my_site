module Services::Admin::Routes
  # Logout
  post "/admin/logout" do |env|
    lang_code : String = env.session.string("current_lang")
    auth = Globals::Auth.user_authenticated? env, lang_code
    authenticated? : Bool = auth[:is_authenticated]
    if authenticated?
      env.session.destroy
    end
    result = {is_authenticated: authenticated?}.to_json
    env.response.content_type = "application/json"
    result
  end
end
