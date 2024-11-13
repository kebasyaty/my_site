module Services::Admin::Routes
  # Get language code and parameters for admin panal.
  post "/admin/get-parameters" do |env|
    lang_code : String = env.session.string("current_lang")
    auth = Globals::Auth.user_authenticated? env, lang_code
    authenticated? : Bool = auth[:is_authenticated] && auth[:is_admin]
    site_params = Services::Admin::Models::SiteParams.find_one_to_instance.not_nil!
    result = {
      is_authenticated: authenticated?,
      lang_code:        lang_code,
      logo:             site_params.logo.value.url_md,
      brand:            site_params.brand.value || "",
      slogan:           site_params.slogan.value || "",
      bg_image:         if !(value = site_params.bg_image.value?).nil?
        value.url
      else
        ""
      end,
      bg_opacity:  site_params.bg_opacity.value,
      dark_theme:  site_params.dark_theme.value,
      color_theme: site_params.color_theme.value,
    }.to_json
    env.response.content_type = "application/json"
    result
  end
end
