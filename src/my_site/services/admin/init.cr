module Vizbor::Services::Admin
  # Code that must be executed before the web server starts.
  struct Init < Vizbor::Init
    def self.some_code : Nil
      # ...
    end
  end
end
