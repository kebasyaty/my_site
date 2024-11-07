module Services::Admin::Routes
  # Change current language
  get "/admin/change-current-lang" do |env|
    lang_code = env.params.json["lang_code"].as(String)
    auth = Globals::Auth.user_authenticated? env, lang_code
    authenticated? : Bool = auth[:is_authenticated] && auth[:is_admin]
    env.session.string("current_lang", lang_code)
    result = {is_authenticated: authenticated?}.to_json
    env.response.content_type = "application/json"
    result
  end
end
