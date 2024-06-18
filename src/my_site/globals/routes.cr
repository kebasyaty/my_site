module Vizbor::Globals::Routes
  get "/favicon.ico" do |env|
    send_file env, "public/static/favicons/favicon.ico"
  end

  get "/robots.txt" do |env|
    env.response.content_type = "text/plain"
    Vizbor::Render.robots(
      host: "#{Vizbor::Settings.host}:#{Vizbor::Settings.port}",
      scheme: Vizbor::Settings.scheme,
    )
  end

  get "/sitemap.xml" do |env|
    _items : Array(NamedTuple(
      loc: String,
      lastmod: String,
      changefreq: String,
      priority: Float64,
    )) = [{loc: "test_loc", lastmod: "test_lastmod", changefreq: "test_changefreq", priority: 0.5}]
    env.response.content_type = "application/xml"
    render "templates/sitemap.xml.ecr"
  end

  error 404 do |env|
    send_file env, "views/404.html"
  end
end
