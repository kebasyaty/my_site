# Additional tools for Models.
module Globals::Auth
  extend self

  # User authorization
  def user_authentication(
    env : HTTP::Server::Context,
    login : String, # username or email
    password : String
  ) : NamedTuple(
    is_authenticated: Bool,
    is_admin: Bool,
    is_active: Bool,
    user: Services::Admin::Models::User?,
  )
    authenticated? : Bool = false
    filter = Hash(String, String).new
    if Valid.email? login
      filter["email"] = login
    else
      filter["username"] = login
    end
    user : Services::Admin::Models::User? = nil
    if user = Services::Admin::Models::User.find_one_to_instance(filter)
      # User password verification
      if user.verify_password(password)
        # Update last visit date
        user.last_login.refrash_val_datetime(Time.utc)
        if user.save
          authenticated? = true
        else
          user.print_err
        end
        if authenticated?
          env.session.string("user_hash", user.hash.value)
          return {
            is_authenticated: authenticated?,
            is_admin:         user.is_admin.value,
            is_active:        user.is_active.value,
            user:             user,
          }
        end
      end
    end
    {is_authenticated: false, is_admin: false, is_active: false, user: nil}
  end

  # Check if the user is authenticated?
  def user_authenticated?(
    env : HTTP::Server::Context
  ) : NamedTuple(
    is_authenticated: Bool,
    is_admin: Bool,
    is_active: Bool,
    user: Services::Admin::Models::User?,
  )
    user : Services::Admin::Models::User? = nil
    if !(user_hash = env.session.string?("user_hash")).nil?
      filter = {_id: BSON::ObjectId.new(user_hash.as(String))}
      if user = Services::Admin::Models::User.find_one_to_instance(filter)
        return {
          is_authenticated: user.is_active.value,
          is_admin:         user.is_admin.value,
          is_active:        user.is_active.value,
          user:             user,
        }
      else
        env.session.destroy
      end
    end
    {is_authenticated: false, is_admin: false, is_active: false, user: nil}
  end
end
