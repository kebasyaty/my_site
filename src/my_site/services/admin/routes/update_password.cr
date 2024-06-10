module Vizbor::Services::Admin::Routes
  # Update password
  post "/admin/update-password" do |env|
    authenticated? : Bool = false
    lang_code : String = Vizbor::Settings.default_locale
    msg_err : String = ""
    username : String = env.params.json["username"].as(String)
    old_pass : String = env.params.json["old_pass"].as(String)
    new_pass : String = env.params.json["new_pass"].as(String)
    model_key : String = env.params.json["model_key"].as(String)
    doc_hash : String = env.params.json["doc_hash"].as(String)

    # User authentication
    if !(user = env.session.object?("user")).nil?
      user = user.as(Vizbor::Middleware::Session::UserStorableObject)
      if user.is_admin? && user.is_active?
        authenticated? = true
      else
        msg_err = I18n.t(:auth_failed)
      end
    end

    result : String? = nil
    I18n.with_locale(lang_code) do
      result = {
        is_authenticated: authenticated?,
        service_list:     Vizbor::Compose.get,
        msg_err:          msg_err,
      }.to_json
    end
    env.response.content_type = "application/json"
    result
  end
end
