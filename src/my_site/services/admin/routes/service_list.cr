module Vizbor::Services::Admin::Routes
  # Get service list
  post "/admin/service-list" do |env|
    lang_code : String = env.session.string("current_lang")
    auth = Vizbor::Globals::Auth.user_authenticated? env, is_admin?: true
    authenticated? : Bool = auth[:authenticated?]

    result : String? = nil
    I18n.with_locale(lang_code) do
      result = {
        is_authenticated: authenticated?,
        service_list:     Vizbor::Composition.get,
        msg_err:          authenticated? ? "" : I18n.t(:auth_failed),
      }.to_json
    end
    env.response.content_type = "application/json"
    result
  end
end
