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
end
