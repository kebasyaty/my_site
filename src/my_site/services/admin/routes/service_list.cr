module Vizbor::Services::Admin::Routes
  # Get service list
  post "/admin/service-list" do |env|
    lang_code : String = env.session.string("current_lang")
    auth = Vizbor::Globals::Auth.user_authenticated? env, is_admin?: true
    authenticated? : Bool = auth[:authenticated?]
    basic_params = Vizbor::Services::Admin::Models::SiteParams.find_one_to_instance
    if basic_params.nil?
      halt env, status_code: 400, response: "Basic settings are missing."
    end

    result : String? = nil
    I18n.with_locale(lang_code) do
      result = {
        brand:            basic_params.brand.value,
        slogan:           basic_params.slogan.value,
        is_authenticated: authenticated?,
        service_list:     Vizbor::MenuComposition.get,
        msg_err:          authenticated? ? "" : I18n.t(:auth_failed),
      }.to_json
    end
    env.response.content_type = "application/json"
    result
  end
end
