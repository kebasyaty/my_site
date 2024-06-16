module Vizbor::Services::Home::Routes
  # Home page
  get "/" do |env|
    _lang_code = Vizbor::Settings.default_locale
    basic_params = Vizbor::Services::Admin::Models::BasicSettings.find_one_to_instance
    _brand = basic_params.brand
    _slogan = basic_params.slogan
    home_params = Vizbor::Services::Home::Models::HomePageSettings.find_one_to_instance
    _meta_title = home_params.meta_title
    _meta_description = home_params.meta_description
    _content = ""
    _styles = Array(String).new
    _scripts = Array(String).new
    env.response.content_type = "text/html"
    render "views/layouts/home.html.ecr"
  end
end
