# https://kemalcr.com/guide/#middleware
module Vizbor::Middleware
  # Session Configuration.
  # https://github.com/kemalcr/kemal-session
  Kemal::Session.config do |config|
    # How long is the session valid after last user interaction?
    config.timeout = 1.hours
    # Name of the cookie that holds the session_id on the client.
    config.cookie_name = Vizbor::Settings.app_name
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
    http_only: true,
  )
end
