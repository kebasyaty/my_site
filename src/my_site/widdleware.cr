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
    response.headers.add("Access-Control-Max-Age", Vizbor::Settings.debug? ? "-1" : "3600")
    # Add Headers
    response.headers.add("Content-Size", filestat.size.to_s)
    response.headers.add("X-XSS-Protection", "1; mode=block")
    response.headers.add("X-Frame-Options", "deny")
    response.headers.add("X-Content-Type-Options", "nosniff")
    response.headers.add(
      "Strict-Transport-Security",
      Vizbor::Settings.debug? ? "max-age=0" : "max-age=31536000; includeSubDomains; preload",
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
      " object-src 'none';" % {s: Vizbor::Settings.debug? ? "" : "s"}
    )
  end

  # Session Configuration.
  # https://github.com/kemalcr/kemal-session
  Kemal::Session.config do |config|
    # How long is the session valid after last user interaction?
    config.timeout = 1.hours
    # Name of the cookie that holds the session_id on the client.
    config.cookie_name = "#{Vizbor::Settings.app_name.downcase.gsub(" ", "_")}_session"
    # How are the sessions saved on the server?
    # https://github.com/kemalcr/kemal-session#setting-the-engine
    config.engine = Kemal::Session::MemoryEngine.new
    # In which interval should the garbage collector find and delete expired sessions from the server?
    config.gc_interval = 4.minutes
    # Used to sign the session ids before theyre saved in the cookie.
    config.secret = Vizbor::Settings.secret_key
    # The cookie used for session management should only be transmitted over encrypted connections.
    config.secure = !Vizbor::Settings.debug?
    # Domain to use to scope cookie.
    config.domain = Vizbor::Settings.domain_name
    # Scope cookie to a particular path.
    config.path = "/"
  end

  # CSRF Configuration.
  # https://github.com/kemalcr/kemal-csrf
  # To access the CSRF token of the active session you can do the following in your .ecr form(s):
  # <input type="hidden" name="authenticity_token" value='<%= env.session.string("csrf") %>'>
  add_handler CSRF.new(
    header: "X_CSRF_TOKEN",
    allowed_methods: ["GET", "OPTIONS", "TRACE"],
    parameter_name: "authenticity_token",
    error: "Forbidden (CSRF)",
    allowed_routes: [] of String,
    http_only: !Vizbor::Settings.debug?,
  )
end
