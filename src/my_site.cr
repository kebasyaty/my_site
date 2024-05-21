require "vizbor"
require "./my_site/**"

module MySite
  VERSION = "0.1.0"

  # Start Web Server.
  Vizbor::Server.run
end
