module Services::Admin::Routes
  # Get language code and main parameters for admin panal.
  post "/admin/get-parameters" do |env|
    lang_code : String = env.session.string("current_lang")
    auth = Globals::Auth.user_authenticated? env, lang_code
    authenticated? : Bool = auth[:is_authenticated] && auth[:is_admin]
    main_params = Services::Admin::Models::MainParams.find_one_to_instance.not_nil!
    img_val : DynFork::Globals::ImageData?
    result = {
      is_authenticated: authenticated?,
      csrf:             env.session.string("csrf"),
      lang_code:        lang_code,
      logo:             (img_val.url_md if img_val = main_params.logo.value?) || "",
      brand:            main_params.brand.value? || "",
      slogan:           main_params.slogan.value? || "",
      bg_image:         (img_val.url if img_val = main_params.bg_image.value?) || "",
      bg_opacity:       main_params.bg_opacity.value,
      dark_theme:       main_params.dark_theme.value,
      color_theme:      main_params.color_theme.value,
    }.to_json
    env.response.content_type = "application/json"
    result
  end
end
