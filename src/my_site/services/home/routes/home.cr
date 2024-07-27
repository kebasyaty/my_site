module Services::Home::Routes
  # Home page
  get "/" do |env|
    lang_code : String = env.session.string("current_lang") # or env.params.url["lang_code"]
    auth = Globals::Auth.user_authenticated? env, lang_code
    site_params = Services::Admin::Models::SiteParams.find_one_to_hash.not_nil!
    home_params = Services::Home::Models::HomePageParams.find_one_to_hash.not_nil!
    env.response.content_type = "text/html"
    Globals::Renders.base(
      lang_code: Vizbor::Settings.default_locale, # or env.params.url["lang_code"]
      meta_title: home_params["meta_title"],
      meta_description: home_params["meta_description"],
      header: Globals::Renders.base_header(
        brand: site_params["brand"],
        slogan: site_params["slogan"],
      ),
      content: auth[:is_authenticated] ? Globals::Renders.base_content : Globals::Renders.login_content(env),
      footer: Globals::Renders.base_footer(
        contact_email: site_params["contact_email"],
        contact_phone: site_params["contact_phone"],
      ),
      styles: Array(String).new,
      scripts: Array(String).new,
    )
  end
end
