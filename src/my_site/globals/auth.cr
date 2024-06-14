# Additional tools for Models.
module Vizbor::Globals::Auth
  extend self

  # User authorization
  def user_authentication(
    env : HTTP::Server::Context,
    login : String, # username or email
    password : String,
    is_admin? : Bool = false
  ) : NamedTuple(authenticated?: Bool, user: Vizbor::Services::Admin::Models::User?)
    authenticated? : Bool = false
    filter = Hash(String, BSON::ObjectId | String | Bool).new
    if Valid.email? login
      filter["email"] = login
    else
      filter["username"] = login
    end
    filter["is_admin?"] = true if is_admin?
    filter["is_active"] = true
    user : Vizbor::Services::Admin::Models::User? = nil
    if user = Vizbor::Services::Admin::Models::User.find_one_to_instance(filter)
      # User password verification
      if user.verify_password(password)
        # Update last visit date
        user.last_login.refrash_val_datetime(Time.utc)
        if user.save
          authenticated? = true
        else
          user.print_err
        end
        # Add user details to session
        if authenticated?
          env.session.string("hash", user.hash.value)
          env.session.string("lang", user.hash.value)
        end
      end
    end
    {authenticated?: authenticated?, user: user}
  end

  # Check if the user is authenticated?
  def user_authenticated?(
    env : HTTP::Server::Context,
    is_admin? : Bool = false
  ) : NamedTuple(authenticated?: Bool, user: Vizbor::Services::Admin::Models::User?)
    user : Vizbor::Services::Admin::Models::User? = nil
    if !(uso = env.session.object?("user")).nil?
      uso = uso.as(Vizbor::Middleware::Session::UserStorableObject)
      filter = Hash(String, BSON::ObjectId | Bool).new
      filter["_id"] = BSON::ObjectId.new(uso.hash)
      filter["is_admin?"] = true if is_admin?
      filter["is_active"] = true
      if (user = Vizbor::Services::Admin::Models::User.find_one_to_instance(filter)).nil?
        env.session.destroy
      end
    end
    {authenticated?: !user.nil?, user: user}
  end
end
