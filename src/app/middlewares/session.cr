# https://kemalcr.com/guide/#middleware
module Vizbor::Middleware
  # Session Configuration.
  # https://github.com/kemalcr/kemal-session
  Kemal::Session.config do |config|
    # How long is the session valid after last user interaction?
    config.timeout = 1.hours
    # Name of the cookie that holds the session_id on the client.
    config.cookie_name = "kemal_session"
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
    config.domain = !Vizbor::Settings.debug? ? Vizbor::Settings.host : nil
    # Scope cookie to a particular path.
    config.path = "/"
    config.samesite = HTTP::Cookie::SameSite::Lax
  end

  # Add the current language code to the session.
  class CurrentLang < Kemal::Handler
    def call(env)
      if env.session.string?("current_lang").nil?
        env.session.string("current_lang", Vizbor::Settings.default_locale)
      end
      call_next env
    end
  end

  add_handler CurrentLang.new
end
