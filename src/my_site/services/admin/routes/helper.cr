# Auxiliary elements for routes
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
    property language_code : String

    def initialize(
      @hash : String,
      @username : String,
      @email : String,
      @is_admin : Bool,
      @is_active : Bool,
      @language_code : String
    ); end
  end
end
