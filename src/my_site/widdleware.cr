# https://kemalcr.com/guide/#middleware
module Vizbor::Middleware
  add_handler CSRF.new(
    header: "X_CSRF_TOKEN",
    allowed_methods: ["GET", "HEAD", "OPTIONS", "TRACE"],
    allowed_routes: ["/api/somecallback", "/api/v1/**"],
    parameter_name: "_csrf",
    error: "CSRF Error",
    http_only: false,
    samesite: nil,
  )
end
