# Settings for your web application.
module Vizbor::Settings
  # If true,
  # an exception page is rendered when an exception is raised which provides a
  # lot of useful information for debugging.
  class_getter? debug : Bool = true
  # Maximum 44 characters.
  class_getter app_name : String = "MySite"
  # Match regular expression: /^[a-zA-Z0-9]{16}$/
  # To generate a key (This is not an advertisement): https://randompasswordgen.com/
  class_getter unique_app_key : String = "6DfInSVrUeCjmpO2"
  # Maximum 60 characters.
  # Hint: If the line is empty, the name will be generated automatically.
  class_getter database_name : String = ""
  # https://github.com/crystal-i18n/i18n
  class_getter default_locale : Symbol = :en
  # Domain names.
  class_getter domain_name : String = @@debug ? "0.0.0.0" : "www.your-site-name.net"
  # Port for test server.
  class_getter port : Int32 = 3000
  # Static File Options.
  # https://kemalcr.com/guide/
  # Example: {"gzip" => true, "dir_listing" => false}
  class_getter! static_file_options : Hash(String, Bool)
  # Disable Static Files.
  class_getter? disable_static_files : Bool = false
  # Using Reuse Port for Multiple Kemal Processes.
  # https://kemalcr.com/cookbook/reuse_port/
  class_getter? server_reuse_port : Bool = false
  # Use Logging?
  # https://kemalcr.com/guide/
  # You can add logging statements to your code:
  # Example: Log.info { "Log message with or without embedded #{variables}" }
  class_getter? use_logging : Bool = true
  # Security
  # To generate a key (This is not an advertisement): https://randompasswordgen.com/
  # Minimum 64 characters.
  class_getter secret_key : String = "a0d8207419bd18daeb73a6190c5b4603aa01b5eccb23c9ebe07536d883a51070c0e6d3ce8eff9fb860c91489dfbb69745ebee7e8d7d3c850427d53f0f645c513"
end
