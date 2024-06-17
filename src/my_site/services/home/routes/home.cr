module Vizbor::Services::Home::Routes
  # Home page
  get "/" do |env|
    env.response.content_type = "text/html"
    basic_params = Vizbor::Services::Admin::Models::BasicSettings.find_one_to_hash.not_nil!
    home_params = Vizbor::Services::Home::Models::HomePageSettings.find_one_to_hash.not_nil!
    Vizbor::Renders.base(
      lang_code: Vizbor::Settings.default_locale,
      brand: basic_params["brand"].to_s,
      slogan: basic_params["slogan"].to_s,
      contact_email: basic_params["contact_email"].to_s,
      contact_phone: basic_params["contact_phone"].to_s,
      meta_title: home_params["meta_title"].to_s,
      meta_description: home_params["meta_description"].to_s,
      content: "Some content ...",
      styles: Array(String).new,
      scripts: Array(String).new,
    )
  end
end
