module Vizbor::Services::Home::Routes
  # Home page
  get "/" do |env|
    _lang_code = ""
    _meta_title = ""
    _meta_description = ""
    _brand = ""
    _slogan = ""
    _content = ""
    _styles = Array(String).new
    _scripts = Array(String).new
    env.response.content_type = "text/html"
    render "views/layouts/home.html.ecr"
  end
end
