# https://kemalcr.com/guide/#middleware
module Vizbor::Middleware
  # Adds headers to Kemal::StaticFileHandler.
  # This is especially useful for stuff like CORS or caching.
  static_headers do |response, _filepath, filestat|
    # Add CORS
    response.headers.add("Access-Control-Allow-Origin", Vizbor::Settings.app_url)
    response.headers.add("Access-Control-Allow-Methods", "GET")
    response.headers.add("Access-Control-Allow-Headers", "authorization, accept, content-type")
    response.headers.add("Access-Control-Max-Age", !Vizbor::Settings.debug? ? "3600" : "-1")
    # Add Headers
    response.headers.add("Content-Size", filestat.size.to_s)
    response.headers.add("X-XSS-Protection", "1; mode=block")
    response.headers.add("X-Frame-Options", "deny")
    response.headers.add("X-Content-Type-Options", "nosniff")
    response.headers.add(
      "Strict-Transport-Security",
      !Vizbor::Settings.debug? ? "max-age=31536000; includeSubDomains; preload" : "max-age=0",
    )
    response.headers.add("Referrer-Policy", !Vizbor::Settings.debug? ? "strict-origin-when-cross-origin" : "unsafe-url")
    response.headers.add(
      "Content-Security-Policy",
      "default-src 'self';" \
      " connect-src 'self' ws: http%{s}:;" \
      " font-src 'self' data: 'unsafe-inline' http%{s}:;" \
      " img-src 'self' data: content: blob: http%{s}:;" \
      " media-src 'self' http%{s}:;" \
      " style-src 'self' 'unsafe-inline' http%{s}:;" \
      " script-src 'self' 'unsafe-inline' 'unsafe-eval' http%{s}:;" \
      " frame-src 'self' http%{s}:;" \
      " frame-ancestors 'self' http%{s}:;" \
      " object-src 'none';" % {s: !Vizbor::Settings.debug? ? "s" : ""}
    )
  end
end
