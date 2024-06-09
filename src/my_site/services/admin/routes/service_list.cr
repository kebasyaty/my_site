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
      end
    end

    result : String? = nil
    I18n.with_locale(lang_code) do
      result = {
        is_authenticated: authenticated?,
        logo:             "",
        brand:            "Brand ???",
        slogan:           "Slogan ???",
        service_list:     Vizbor::Compose.get,
        msg_err:          authenticated? ? "" : I18n.t(:auth_failed),
      }.to_json
    end
    env.response.content_type = "application/json"
    result
  end
end
