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
    if !(user = env.session.object?("user")).nil?
      user = user.as(Vizbor::Middleware::Session::UserStorableObject)
      authenticated? = true if is_admin? == user.is_admin?
    end
    authenticated?
  end
end
