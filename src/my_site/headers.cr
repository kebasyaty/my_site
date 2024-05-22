module Vizbor::StaticHeaders
  # Adds headers to Kemal::StaticFileHandler.
  # This is especially useful for stuff like CORS or caching.
  static_headers do |response, filepath, filestat|
    response.headers.add("Access-Control-Allow-Origin", Vizbor::Settings.domain_name)
    response.headers.add("Access-Control-Allow-Methods", "GET")
    response.headers.add("Access-Control-Allow-Headers", "content-type,authorization,accept")
    response.headers.add("Access-Control-Max-Age", Vizbor::Settings.debug? ? "-1" : "3600")
    response.headers.add("", "")
    #
    response.headers.add("Content-Size", filestat.size.to_s)
    response.headers.add("X-XSS-Protection", "1; mode=block")
    response.headers.add("X-Frame-Options", "deny")
    response.headers.add("X-Content-Type-Options", "nosniff")
    response.headers.add("Content-Security-Policy", "")
    response.headers.add(
      "Strict-Transport-Security",
      Vizbor::Settings.debug? ? "max-age=0" : "max-age=31536000; includeSubDomains; preload",
    )
    response.headers.add("Referrer-Policy", "strict-origin-when-cross-origin")
    response.headers.add("", "")
    response.headers.add("", "")
    response.headers.add("", "")
  end
end
