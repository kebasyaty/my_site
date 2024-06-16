module Vizbor::Services::Home::Routes
  # Home page
  get "/" do
    _lang_code =
      env.response.content_type = "text/html"
    render "views/layouts/home.html.ecr"
  end
end
