# https://kemalcr.com/guide/#middleware
module Vizbor::Middleware
  # CSRF
  # https://github.com/kemalcr/kemal-csrf
  add_handler CSRF.new(
    header: "X_CSRF_TOKEN",
    allowed_methods: ["GET", "HEAD", "OPTIONS", "TRACE"],
    parameter_name: "authenticity_token",
    error: "Forbidden (CSRF)",
    allowed_routes: [] of String,
    http_only: false,
    samesite: nil,
  )
end
