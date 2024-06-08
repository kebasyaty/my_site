module Vizbor::Services::Home
  # Code that must be executed before the web server starts.
  struct Init < Vizbor::Init
    def self.some_code
      # ...
    end
  end
end
