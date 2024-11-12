module Services::Admin::Routes
  # Get language code and parameters for admin panal.
  post "/admin/get-parameters" do |env|
    lang_code : String = env.session.string("current_lang")
    auth = Globals::Auth.user_authenticated? env, lang_code
    authenticated? : Bool = auth[:is_authenticated] && auth[:is_admin]

    site_params = Services::Admin::Models::SiteParams.find_one_to_hash.not_nil!
    logo = site_params["logo"].not_nil!.as(DynFork::Globals::Types::ImageData)
    result = {
      is_authenticated: authenticated?,
      lang_code:        lang_code,
      logo:             logo.url_md,
      brand:            site_params["brand"] || "",
      slogan:           site_params["slogan"] || "",
      dark_theme:       site_params["dark_theme"],
      color_theme:      site_params["color_theme"],
    }.to_json
    env.response.content_type = "application/json"
    result
  end
end
