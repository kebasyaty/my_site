module Vizbor::BasicRoutes
  get "/favicon.ico" do |env|
    send_file env, "assets/static/favicons/favicon.ico"
  end

  get "/favicons/:icon" do |env|
    icon = env.params.url["icon"]
    send_file env, "assets/static/favicons/#{icon}"
  end

  get "/robots.txt" do |env|
    env.response.content_type = "text/plain"
    host = Vizbor::Settings.domain_name
    scheme = !Vizbor::Settings.debug? ? "https" : "http"
    render "templates/robots.ecr"
  end

  get "/sitemap.xml" do
    # ...
  end

  error 404 do
    render "templates/404.ecr"
  end
end
