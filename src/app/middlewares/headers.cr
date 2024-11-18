# https://kemalcr.com/guide/#middleware
module Vizbor::Middleware
  # Adds headers to Kemal::StaticFileHandler.
  # This is especially useful for stuff like CORS or caching.
  static_headers do |env, _filepath, filestat|
    # Add CORS
    env.response.headers.add("Access-Control-Allow-Origin", Vizbor::Settings.app_url)
    env.response.headers.add("Access-Control-Allow-Methods", "GET")
    env.response.headers.add("Access-Control-Allow-Headers", "authorization, accept, content-type")
    env.response.headers.add("Access-Control-Max-Age", !Vizbor::Settings.debug? ? "3600" : "-1")
    # Add Headers
    env.response.headers.add("Content-Size", filestat.size.to_s)
    env.response.headers.add("X-XSS-Protection", "1; mode=block")
    env.response.headers.add("X-Frame-Options", "deny")
    env.response.headers.add("X-Content-Type-Options", "nosniff")
    env.response.headers.add(
      "Strict-Transport-Security",
      !Vizbor::Settings.debug? ? "max-age=31536000; includeSubDomains; preload" : "max-age=0",
    )
    env.response.headers.add("Referrer-Policy", !Vizbor::Settings.debug? ? "strict-origin-when-cross-origin" : "unsafe-url")
    env.response.headers.add(
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
