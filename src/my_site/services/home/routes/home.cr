module Vizbor::Services::Home::Routes
  # Home page
  get "/" do |env|
    site_params = Vizbor::Services::Admin::Models::SiteParams.find_one_to_hash.not_nil!
    home_params = Vizbor::Services::Home::Models::HomePageParams.find_one_to_hash.not_nil!
    env.response.content_type = "text/html"
    Vizbor::Renderer.base(
      lang_code: Vizbor::Settings.default_locale,
      brand: site_params["brand"],
      slogan: site_params["slogan"],
      contact_email: site_params["contact_email"],
      contact_phone: site_params["contact_phone"],
      meta_title: home_params["meta_title"],
      meta_description: home_params["meta_description"],
      content: "Some renderer for content ...", # Example: Vizbor::Renderer.content(...)
      styles: Array(String).new,
      scripts: Array(String).new,
    )
  end
end
