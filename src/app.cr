require "vizbor"
require "./app/settings"
require "./app/globals/**"
require "./app/middlewares/**"
require "./app/services/**"

module App
  VERSION = "0.1.0"

  Vizbor::Server.run
end
