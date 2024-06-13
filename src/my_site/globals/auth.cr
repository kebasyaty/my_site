# Additional tools for Models.
module Vizbor::Globals::Auth
  extend self

  # User authorization
  def user_authentication(
    env : HTTP::Server::Context,
    is_admin? : Bool = false
  )
    # ...
  end

  # Check if the user is authenticated?
  def user_authenticated?(
    env : HTTP::Server::Context,
    is_admin? : Bool = false
  ) : Bool
    authenticated? : Bool = false
    if !(uso = env.session.object?("user")).nil?
      uso = uso.as(Vizbor::Middleware::Session::UserStorableObject)
      filter = {
        "_id":     BSON::ObjectId.new(uso.hash),
        username:  uso.username,
        email:     uso.email,
        is_admin:  is_admin?,
        is_active: true,
      }
      if user = Vizbor::Services::Admin::Models::User.find_one_to_instance(filter)
        authenticated? = true
      end
    end
    authenticated?
  end
end
