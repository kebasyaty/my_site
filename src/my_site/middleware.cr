# https://kemalcr.com/guide/#middleware
module Vizbor::Middleware
  # Headers.
  # Adds headers to Kemal::StaticFileHandler.
  # This is especially useful for stuff like CORS or caching.
  static_headers do |response, _filepath, filestat|
    # Add CORS
    response.headers.add("Access-Control-Allow-Origin", Vizbor::Settings.app_url)
    response.headers.add("Access-Control-Allow-Methods", "GET")
    response.headers.add("Access-Control-Allow-Headers", "origin, content-type, accept")
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
    response.headers.add("Referrer-Policy", "strict-origin-when-cross-origin")
    response.headers.add(
      "Content-Security-Policy",
      "Content-Security-Policy" \
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

  # CSRF Configuration.
  # https://github.com/kemalcr/kemal-csrf
  # To access the CSRF token of the active session you can do the following in your .ecr form(s):
  # <input type="hidden" name="authenticity_token" value='<%= env.session.string("csrf") %>'>
  add_handler CSRF.new(
    header: "X_CSRF_TOKEN",
    allowed_methods: ["GET", "POST", "OPTIONS", "TRACE"],
    parameter_name: "authenticity_token",
    error: "Forbidden (CSRF)",
    allowed_routes: [] of String,
    http_only: !Vizbor::Settings.debug?,
    samesite: HTTP::Cookie::SameSite::Lax
  )
end
