module Globals::Routes
  get "/favicon.ico" do |env|
    send_file env, "public/static/favicons/favicon.ico"
  end

  get "/robots.txt" do |env|
    env.response.content_type = "text/plain"
    Renders.robots(
      host: Vizbor::Settings.host,
      scheme: Vizbor::Settings.scheme,
    )
  end

  get "/sitemap.xml" do |env|
    env.response.content_type = "application/xml"
    Renders.sitemap(
      items: [{loc: "test_loc", lastmod: "test_lastmod", changefreq: "test_changefreq", priority: 0.5}],
    )
  end

  # Login
  post "/login" do |env|
    auth = Globals::Auth.user_authenticated? env
    unless auth[:is_authenticated]
      Globals::Auth.user_authentication(
        env,
        login: env.params.json["login"].as(String), # username or email
        password: env.params.json["password"].as(String),
      )
    end
    env.redirect "/"
  end

  # Logout
  post "/logout" do |env|
    auth = Globals::Auth.user_authenticated? env
    if auth[:is_authenticated]
      env.session.destroy
    end
    env.redirect "/"
  end

  error 404 do |env|
    send_file env, "views/404.html"
  end
end
