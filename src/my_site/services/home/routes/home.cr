module Vizbor::Services::Home::Routes
  # Home page
  get "/" do |env|
    site_params = Vizbor::Services::Admin::Models::SiteParams.find_one_to_hash.not_nil!
    home_params = Vizbor::Services::Home::Models::HomePageParams.find_one_to_hash.not_nil!
    env.response.content_type = "text/html"
    Vizbor::Render.base(
      lang_code: Vizbor::Settings.default_locale,
      meta_title: home_params["meta_title"],
      meta_description: home_params["meta_description"],
      header: Vizbor::Render.base_header(
        brand: site_params["brand"],
        slogan: site_params["slogan"],
      ),
      content: Vizbor::Render.base_content,
      footer: Vizbor::Render.base_footer(
        contact_email: site_params["contact_email"],
        contact_phone: site_params["contact_phone"],
      ),
      styles: Array(String).new,
      scripts: Array(String).new,
    )
  end
end
