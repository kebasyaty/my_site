module Vizbor::Services::Admin::Routes
  # To store user data in a session
  class UserStorableObject
    include JSON::Serializable
    include Kemal::Session::StorableObject

    getter hash : String
    getter username : String
    getter email : String
    getter? is_admin : Bool
    getter? is_active : Bool

    def initialize(
      @hash : String,
      @username : String,
      @email : String,
      @is_admin : Bool,
      @is_active : Bool
    ); end
  end

  # Admin panel page
  get "/admin" do |env|
    env.redirect "/admin/sign-in"
  end

  # Get language code
  get "/admin/language-code" do |env|
    language_code = {
      language_code: Vizbor::Settings.default_locale,
      msg_err:       "",
    }.to_json
    env.response.content_type = "application/json"
    language_code
  end
end
