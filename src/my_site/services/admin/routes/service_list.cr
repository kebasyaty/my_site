module Vizbor::Services::Admin::Routes
  # Get service list
  post "/admin/service-list" do |env|
    is_authenticated : Bool = false
    msg_err : String = ""

    if !(user = env.session.object?("user")).nil?
      user = user.as(Vizbor::Session::UserStorableObject)
      if !user.username.empty? &&
         !user.hash.empty? && user.is_admin? && user.is_active?
        is_authenticated = true
      else
        msg_err = I18n.t(:auth_failed)
      end
    else
      msg_err = I18n.t(:auth_failed)
    end

    result = {
      is_authenticated: is_authenticated,
      logo:             "",
      brand:            "Brand ???",
      slogan:           "Slogan ???",
      service_list:     Vizbor::Compose.get,
      msg_err:          msg_err,
    }.to_json
    env.response.content_type = "application/json"
    result
  end
end
