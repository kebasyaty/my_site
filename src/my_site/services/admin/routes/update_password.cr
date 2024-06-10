module Vizbor::Services::Admin::Routes
  # Update password
  post "/admin/update-password" do |env|
    authenticated? : Bool = false
    lang_code : String = Vizbor::Settings.default_locale
    username : String = env.params.json["username"].as(String)
    old_pass : String = env.params.json["old_pass"].as(String)
    new_pass : String = env.params.json["new_pass"].as(String)
    model_key : String = env.params.json["model_key"].as(String)
    doc_hash : String = env.params.json["doc_hash"].as(String)

    # Let's check that the administrator is authenticated
    if !(user = env.session.object?("user")).nil?
      user = user.as(Vizbor::Middleware::Session::UserStorableObject)
      if user.is_admin? && user.is_active?
        authenticated? = true
      end
    end

    # Update password
    if authenticated?
      if model_key == Vizbor::Services::Admin::Models::User.full_model_name
        # ...
      end
    end

    result : String? = nil
    I18n.with_locale(lang_code) do
      result = {
        is_authenticated: authenticated?,
        service_list:     Vizbor::Compose.get,
        msg_err:          authenticated? ? "" : I18n.t(:auth_failed),
      }.to_json
    end
    env.response.content_type = "application/json"
    result
  end
end
