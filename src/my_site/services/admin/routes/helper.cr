module Vizbor::Services::Admin::Routes
  # To store user data in a session
  class UserStorableObject
    include JSON::Serializable
    include Kemal::Session::StorableObject

    getter hash : String
    getter username : String

    def initialize(
      @hash : String,
      @username : String
    ); end
  end
end
