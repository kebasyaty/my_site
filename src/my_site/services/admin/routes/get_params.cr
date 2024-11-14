module Services::Admin::Routes
  # Get language code and main parameters for admin panal.
  post "/admin/get-parameters" do |env|
    lang_code : String = env.session.string("current_lang")
    auth = Globals::Auth.user_authenticated? env, lang_code
    authenticated? : Bool = auth[:is_authenticated] && auth[:is_admin]
    main_params = Services::Admin::Models::MainParams.find_one_to_instance.not_nil!
    result = {
      is_authenticated: authenticated?,
      lang_code:        lang_code,
      logo:             (value.url_md if value = main_params.logo.value?) || "",
      brand:            main_params.brand.value? || "",
      slogan:           main_params.slogan.value? || "",
      bg_image:         if !(value = main_params.bg_image.value?).nil?
        value.url
      else
        ""
      end,
      bg_opacity:  main_params.bg_opacity.value,
      dark_theme:  main_params.dark_theme.value,
      color_theme: main_params.color_theme.value,
    }.to_json
    env.response.content_type = "application/json"
    result
  end
end
