module Services::Admin::Routes
  # Get language code.
  # Get theme and primary colors.
  get "/admin/lang-code" do |env|
    lang_code : String = env.session.string("current_lang")
    site_params = Services::Admin::Models::SiteParams.find_one_to_hash.not_nil!

    result = {
      lang_code:           lang_code,
      dark_theme:          site_params["dark_theme"],
      light_color_primary: site_params["light_color_primary"],
      dark_color_primary:  site_params["dark_color_primary"],
      msg_err:             "",
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
