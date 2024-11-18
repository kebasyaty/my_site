# Settings for your web application.
module Vizbor::Settings
  extend self

  module Kemal
    extend self
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
  end

  # If true,
  # an exception page is rendered when an exception is raised which provides a
  # lot of useful information for debugging.
  class_getter? debug : Bool = true
  # WARNING: Maximum 60 characters.
  # WARNING: Match regular expression: /^[a-zA-Z][-_a-zA-Z0-9]{0,59}$/
  # NOTE: Not a mandatory format for development and tests: `test_<key>`
  # NOTE: To generate a `<key>` (This is not an advertisement): https://randompasswordgen.com/
  class_getter database_name : String = "test_78iaQbe35yCK45NA1QG38L09W57Zf1RU10O38SJh4nm60z574tSbDW9"
  # NOTE: https://github.com/crystal-i18n/i18n
  class_getter default_locale : String = "en"
  # Security
  # WARNING: Minimum 64 characters.
  class_getter secret_key : String = "d421a07ee91de270852641a9689a8e864e549b9d8bdfaa5785801fab0e3da311d6e64b5b21566095f5a19aa9d0c69efe0972473ec9b825247981ed57c31635a2"

  # The default administrator e -mail, for production.
  # WARNING: Maximum 320 characters.
  class_getter admin_prod_email = "???" # <----------------------------- replace
  # The default administrator e -mail, for development.
  # WARNING: Maximum 320 characters.
  class_getter admin_dev_email = "no_reply@email.net"
  # The default administrator password, for production.
  # WARNING: Number of characters: max=256, min=8.
  # NOTE: To generate a key (This is not an advertisement): https://randompasswordgen.com/
  class_getter admin_prod_pass = "???" # <------------------------------ replace
  # The default administrator password, for development.
  # WARNING: Number of characters: max=256, min=8.
  class_getter admin_dev_pass = "12345678"

  # URI Scheme
  def scheme : String
    "http%{s}" % {s: !@@debug ? "s" : ""}
  end

  # URI Port
  def port : Int32
    3000
  end

  # URI Host
  def host : String
    # "www.your-domain-name.net" <-------------------------------------- replace
    !@@debug ? "www.your-domain-name.net" : "localhost:" + port.to_s
  end

  # Application URL
  def app_url : String
    "%{s}://%{h}" % {s: scheme, h: host}
  end
end
