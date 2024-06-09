module Vizbor::Session
  # Session Configuration.
  # https://github.com/kemalcr/kemal-session
  Kemal::Session.config do |config|
    # How long is the session valid after last user interaction?
    config.timeout = 1.hours
    # Name of the cookie that holds the session_id on the client.
    config.cookie_name = "#{Vizbor::Settings.app_name.downcase.gsub(" ", "_")}_session"
    # How are the sessions saved on the server?
    # https://github.com/kemalcr/kemal-session#setting-the-engine
    config.engine = Kemal::Session::MemoryEngine.new
    # In which interval should the garbage collector find and delete expired sessions from the server?
    config.gc_interval = 4.minutes
    # Used to sign the session ids before theyre saved in the cookie.
    config.secret = Vizbor::Settings.secret_key
    # The cookie used for session management should only be transmitted over encrypted connections.
    config.secure = !Vizbor::Settings.debug?
    # Domain to use to scope cookie.
    config.domain = Vizbor::Settings.host
    # Scope cookie to a particular path.
    config.path = "/"
    config.samesite = HTTP::Cookie::SameSite::Lax
  end

  # To store user data in a session.
  class UserStorableObject
    include JSON::Serializable
    include Kemal::Session::StorableObject

    getter hash : String
    getter username : String
    getter email : String
    getter? is_admin : Bool
    getter? is_active : Bool
    getter lang_code : String

    def initialize(
      @hash : String,
      @username : String,
      @email : String,
      @is_admin : Bool,
      @is_active : Bool,
      @lang_code : String = Vizbor::Settings.default_locale
    ); end
  end

  # To store guest data in a session.
  class GuestStorableObject
    include JSON::Serializable
    include Kemal::Session::StorableObject

    getter lang_code : String

    def initialize(
      @lang_code : String = Vizbor::Settings.default_locale
    ); end
  end
end
