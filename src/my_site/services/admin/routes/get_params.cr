module Services::Admin::Routes
  # Get language code and parameters for admin panal.
  get "/admin/get-parameters" do |env|
    lang_code : String = env.session.string("current_lang")
    auth = Globals::Auth.user_authenticated? env, lang_code
    authenticated? : Bool = auth[:is_authenticated] && auth[:is_admin]

    result : String? = nil
    I18n.with_locale(lang_code) do
      site_params = Services::Admin::Models::SiteParams.find_one_to_hash.not_nil!
      pp site_params
      result = {
        is_authenticated:    authenticated?,
        lang_code:           lang_code,
        brand:               site_params["brand"],
        slogan:              site_params["slogan"],
        light_color_primary: site_params["light_color_primary"],
        dark_color_primary:  site_params["dark_color_primary"],
      }.to_json
    end
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
