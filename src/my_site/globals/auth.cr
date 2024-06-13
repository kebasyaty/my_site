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
  ) : NamedTuple(authenticated?: Bool, user: Vizbor::Services::Admin::Models::User?)
    user : Vizbor::Services::Admin::Models::User? = nil
    if !(uso = env.session.object?("user")).nil?
      uso = uso.as(Vizbor::Middleware::Session::UserStorableObject)
      filter = {
        "_id"       => BSON::ObjectId.new(uso.hash),
        "is_active" => true,
      }
      filter["is_admin?"] = true if is_admin?
      user = Vizbor::Services::Admin::Models::User.find_one_to_instance(filter)
    end
    {authenticated?: !user.nil?, user: user}
  end
end
