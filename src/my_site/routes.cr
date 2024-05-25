module Vizbor::BasicRoutes
  get "/favicon.ico" do |env|
    send_file env, "public/static/favicons/favicon.ico"
  end

  get "/favicons/:icon" do |env|
    icon = env.params.url["icon"]
    send_file env, "public/static/favicons/#{icon}"
  end

  get "/robots.txt" do |env|
    env.response.content_type = "text/plain"
    host = Vizbor::Settings.host
    scheme = Vizbor::Settings.scheme
    render "views/robots.ecr"
  end

  get "/sitemap.xml" do
    env.response.content_type = "application/xml"
    render "views/sitemap.ecr"
  end

  error 404 do
    render "views/404.ecr"
  end
end
