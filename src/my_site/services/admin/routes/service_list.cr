module Services::Admin::Routes
  # Get service list
  post "/admin/service-list" do |env|
    lang_code : String = env.session.string("current_lang")
    auth = Globals::Auth.user_authenticated? env, lang_code
    authenticated? : Bool = auth[:is_authenticated]

    unless auth[:is_admin]
      halt env, status_code: 403, response: "Forbidden"
    end

    site_params = Services::Admin::Models::SiteParams.find_one_to_hash.not_nil!
    result = {
      brand:            authenticated? ? site_params["brand"] : "",
      slogan:           authenticated? ? site_params["slogan"] : "",
      is_authenticated: authenticated?,
      service_list:     authenticated? ? Vizbor::MenuComposition.get : [] of Vizbor::MenuCompositionType,
      msg_err:          authenticated? ? "" : I18n.with_locale(lang_code) { I18n.t(:auth_failed) },
    }.to_json
    env.response.content_type = "application/json"
    result
  end
end
