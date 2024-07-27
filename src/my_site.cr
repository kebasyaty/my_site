require "vizbor"
require "./my_site/settings"
require "./my_site/globals/**"
require "./my_site/middlewares/**"
require "./my_site/services/**"

module MySite
  VERSION = "0.1.0"

  Vizbor::WebServer.run
end
