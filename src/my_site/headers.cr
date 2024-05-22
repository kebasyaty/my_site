module Vizbor::StaticHeaders
  # Adds headers to Kemal::StaticFileHandler.
  # This is especially useful for stuff like CORS or caching.
  static_headers do |response, filepath, filestat|
    if filepath =~ /\.html$/
      response.headers.add("Access-Control-Allow-Origin", "*")
    end
    response.headers.add("Content-Size", filestat.size.to_s)
    response.headers.add("X-XSS-Protection", "1; mode=block")
    response.headers.add("X-Frame-Options", "deny")
    response.headers.add("X-Content-Type-Options", "nosniff")
    response.headers.add("Content-Security-Policy", "")
    response.headers.add(
      "Strict-Transport-Security",
      Vizbor::Settings.debug ? "max-age=0" : "max-age=31536000; includeSubDomains; preload",
    )
    response.headers.add("", "")
    response.headers.add("", "")
    response.headers.add("", "")
    response.headers.add("", "")
  end
end
