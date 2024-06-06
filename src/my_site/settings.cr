# Settings for your web application.
module Vizbor::Settings
  extend self

  # KEMAL PARAMETERS
  # ----------------------------------------------------------------------------

  # Static File Options.
  # NOTE: https://kemalcr.com/guide/
  # NOTE: Example: {"gzip" => true, "dir_listing" => false}
  class_getter! static_file_options : Hash(String, Bool)
  # Disable Static Files.
  class_getter? disable_static_files : Bool = false
  # Using Reuse Port for Multiple Kemal Processes.
  # NOTE: https://kemalcr.com/cookbook/reuse_port/
  class_getter? server_reuse_port : Bool = false
  # Use Logging?
  # NOTE: https://kemalcr.com/guide/
  # NOTE: You can add logging statements to your code:
  # NOTE: Example: Log.info { "Log message with or without embedded #{variables}" }
  class_getter? use_logging : Bool = true

  # VIZBOR PARAMETERS
  # ----------------------------------------------------------------------------

  # If true,
  # an exception page is rendered when an exception is raised which provides a
  # lot of useful information for debugging.
  class_getter? debug : Bool = true
  # WARNING: Maximum 44 characters.
  class_getter app_name : String = "MySite"
  # WARNING: Match regular expression: /^[a-zA-Z0-9]{16}$/
  # NOTE: To generate a key (This is not an advertisement): https://randompasswordgen.com/
  class_getter unique_app_key : String = "f7XF38NO8JQG0Yu8"
  # WARNING: Maximum 60 characters.
  # WARNING: If the line is empty, the name will be generated automatically.
  class_getter database_name : String = ""
  # NOTE: https://github.com/crystal-i18n/i18n
  class_getter default_locale : Symbol = :en
  # Security
  # WARNING: Minimum 64 characters.
  class_getter secret_key : String = "d421a07ee91de270852641a9689a8e864e549b9d8bdfaa5785801fab0e3da311d6e64b5b21566095f5a19aa9d0c69efe0972473ec9b825247981ed57c31635a2"

  # Administrator production email.
  # WARNING: Maximum 320 characters.
  class_getter admin_prod_email = "???"
  # Administrator production password.
  # WARNING: Valid characters by default: a-z A-Z 0-9 - . _ ! " ` ' # % & , : ; < > = @ { } ~ $ ( ) * + / \ ? [ ] ^ |
  # WARNING: Default number of characters: max = 256, min = 8
  # NOTE: To generate a key (This is not an advertisement): https://randompasswordgen.com/
  class_getter admin_prod_pass = "???"

  # URI Scheme
  def scheme : String
    if !@@debug
      "https"
    else
      "http"
    end
  end

  # URI Port
  def port : Int32
    3000
  end

  # URI Host - Domain name
  def host : String
    if !@@debug
      "www.your-site-name.net"
    else
      "0.0.0.0"
    end
  end

  # Application URL
  def app_url : String
    scheme + "://" + host + ":" + port.to_s
  end
end
