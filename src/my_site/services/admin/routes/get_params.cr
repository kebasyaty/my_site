module Services::Admin::Routes
  # Get language code and parameters for admin panal.
  get "/admin/get-parameters" do |env|
    lang_code : String = env.session.string("current_lang")
    auth = Globals::Auth.user_authenticated? env, lang_code
    authenticated? : Bool = auth[:is_authenticated] && auth[:is_admin]

    site_params = Services::Admin::Models::SiteParams.find_one_to_hash.not_nil!
    logo = site_params["logo"].not_nil!.as(DynFork::Globals::Types::ImageData)
    result = {
      is_authenticated: authenticated?,
      lang_code:        lang_code,
      brand:            site_params["brand"],
      slogan:           site_params["slogan"],
      logo:             logo.url_md,
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
