module Vizbor::Services::Admin::Routes
  # Get service list
  post "/admin/service-list" do |env|
    admin_authenticated? : Bool = false
    lang_code : String = Vizbor::Settings.default_locale

    # User authentication
    if !(user = env.session.object?("user")).nil?
      user = user.as(Vizbor::Middleware::Session::UserStorableObject)
      if user.is_admin? && user.is_active?
        admin_authenticated? = true
      end
    end

    result : String? = nil
    I18n.with_locale(lang_code) do
      result = {
        is_authenticated: admin_authenticated?,
        service_list:     Vizbor::Compose.get,
        msg_err:          admin_authenticated? ? "" : I18n.t(:auth_failed),
      }.to_json
    end
    env.response.content_type = "application/json"
    result
  end
end
