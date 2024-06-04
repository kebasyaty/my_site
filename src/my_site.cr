require "vizbor"
require "./my_site/**"

module MySite
  VERSION = "0.1.0"

  Vizbor::WebServer.run
end
