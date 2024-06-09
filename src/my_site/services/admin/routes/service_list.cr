module Vizbor::Services::Admin::Routes
  # Get service list
  post "/admin/service-list" do |env|
    authenticated? : Bool = false
    msg_err : String = ""
    lang_code : String = Vizbor::Settings.default_locale

    if !(user = env.session.object?("user")).nil?
      user = user.as(Vizbor::Session::UserStorableObject)
      if !user.username.empty? &&
         !user.hash.empty? && user.is_admin? && user.is_active?
        lang_code = user.lang_code
        authenticated? = true
      else
        I18n.with_locale(lang_code) do
          msg_err = I18n.t(:auth_failed)
        end
      end
    else
      I18n.with_locale(lang_code) do
        msg_err = I18n.t(:auth_failed)
      end
    end

    I18n.with_locale(lang_code) do
      result = {
        is_authenticated: authenticated?,
        logo:             "",
        brand:            "Brand ???",
        slogan:           "Slogan ???",
        service_list:     Vizbor::Compose.get,
        msg_err:          msg_err,
      }.to_json
      env.response.content_type = "application/json"
      return result
    end
  end
end
