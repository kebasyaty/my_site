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
    _host = "#{Vizbor::Settings.host}:#{Vizbor::Settings.port}"
    _scheme = Vizbor::Settings.scheme
    render "views/robots.ecr"
  end

  get "/sitemap.xml" do |env|
    env.response.content_type = "application/xml"
    _items : Array(NamedTuple(
      loc: String,
      lastmod: String,
      changefreq: String,
      priority: Float64,
    )) = [{loc: "test_loc", lastmod: "test_lastmod", changefreq: "test_changefreq", priority: 0.5}]
    render "views/sitemap.ecr"
  end

  error 404 do
    render "views/404.ecr"
  end
end
