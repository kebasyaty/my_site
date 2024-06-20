module Services::Admin::Routes
  # Get language code
  get "/admin/lang-code" do |env|
    result = {
      lang_code: env.session.string("current_lang"),
      msg_err:   "",
    }.to_json
    env.response.content_type = "application/json"
    result
  end

  # Change current language
  get "/admin/change-current-lang/:lang_code" do |env|
    lang_code = env.params.url["lang_code"]
    env.session.string("current_lang", lang_code)
    env.redirect "/admin"
  end
end
