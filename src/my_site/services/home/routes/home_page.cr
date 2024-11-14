module Services::Home::Routes
  # Home page
  get "/" do |env|
    main_params = Services::Admin::Models::MainParams.find_one_to_instance.not_nil!
    home_page = Services::Home::Models::HomePage.find_one_to_instance.not_nil!
    env.response.content_type = "text/html"
    # WARNING: If necessary, create a custom render in Services::Home::Renders
    Globals::Renders.base(
      lang_code: Vizbor::Settings.default_locale, # or env.params.url["lang_code"]
      meta_title: home_page.meta_title.value,
      meta_description: home_page.meta_description.value,
      header: Globals::Renders.base_header(
        logo: main_params.logo.value.url_md,
        brand: main_params.brand.value,
        slogan: main_params.slogan.value,
      ),
      content: Services::Home::Renders.home_content,
      footer: Globals::Renders.base_footer(
        contact_email: main_params.contact_email.value,
        contact_phone: main_params.contact_phone.value,
      ),
      styles: Array(String).new,
      scripts: Array(String).new,
    )
  end
end
