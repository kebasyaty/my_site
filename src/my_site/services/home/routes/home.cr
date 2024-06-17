module Vizbor::Services::Home::Routes
  # Home page
  get "/" do |env|
    basic_params = Vizbor::Services::Admin::Models::BasicSettings.find_one_to_hash.not_nil!
    home_params = Vizbor::Services::Home::Models::HomePageSettings.find_one_to_hash.not_nil!
    env.response.content_type = "text/html"
    Vizbor::Renderer.base(
      lang_code: Vizbor::Settings.default_locale,
      brand: basic_params["brand"],
      slogan: basic_params["slogan"],
      contact_email: basic_params["contact_email"],
      contact_phone: basic_params["contact_phone"],
      meta_title: home_params["meta_title"],
      meta_description: home_params["meta_description"],
      content: "Some render of content ...",
      styles: Array(String).new,
      scripts: Array(String).new,
    )
  end
end
