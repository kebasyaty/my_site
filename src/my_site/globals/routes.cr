module Vizbor::Globals::Routes
  get "/favicon.ico" do |env|
    send_file env, "public/static/favicons/favicon.ico"
  end

  get "/robots.txt" do |env|
    env.response.content_type = "text/plain"
    Vizbor::Render.robots(
      host: Vizbor::Settings.host,
      scheme: Vizbor::Settings.scheme,
    )
  end

  get "/sitemap.xml" do |env|
    env.response.content_type = "application/xml"
    Vizbor::Render.sitemap(
      items: [{loc: "test_loc", lastmod: "test_lastmod", changefreq: "test_changefreq", priority: 0.5}],
    )
  end

  # Logout
  post "/logout" do |env|
    auth = Vizbor::Globals::Auth.user_authenticated? env, is_admin?: true
    if auth[:authenticated?]
      env.session.destroy
    end
    env.redirect "/"
  end

  # Change current language
  get "/change-current-lang/:lang_code" do |env|
    lang_code = env.params.url["lang_code"]
    env.session.string("current_lang", lang_code)
    env.redirect "/"
  end

  error 404 do |env|
    send_file env, "views/404.html"
  end
end
