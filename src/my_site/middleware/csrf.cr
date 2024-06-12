# https://kemalcr.com/guide/#middleware
module Vizbor::Middleware
  # CSRF Configuration.
  # https://github.com/kemalcr/kemal-csrf
  # NOTE: To access the CSRF token of the active session you can do the following in your .ecr form(s):
  # NOTE: <input type="hidden" name="authenticity_token" value='<%= env.session.string("csrf") %>'>
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
