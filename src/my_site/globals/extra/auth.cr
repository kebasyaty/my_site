# Additional tools for Models.
module Vizbor::Globals::Extra::Auth
  extend self

  # User authorization
  def user_authentication(is_admin? : Bool = false)
    # ...
  end

  # Check if the user is authenticated?
  def user_authenticated?(is_admin? : Bool = false)
    # ...
  end
end
