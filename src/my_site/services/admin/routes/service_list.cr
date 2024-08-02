module Services::Admin::Routes
  # Get service list
  post "/admin/service-list" do |env|
    lang_code : String = env.session.string("current_lang")
    auth = Globals::Auth.user_authenticated? env, lang_code
    authenticated? : Bool = auth[:is_authenticated] && auth[:is_admin]

    result : String? = nil
    I18n.with_locale(lang_code) do
      site_params = Services::Admin::Models::SiteParams.find_one_to_hash.not_nil!
      result = {
        is_authenticated: auth[:is_authenticated],
        brand:            site_params["brand"],
        slogan:           site_params["slogan"],
        service_list:     if authenticated?
          Vizbor::MenuComposition.get
        else
          [] of Vizbor::MenuCompositionType
        end,
      }.to_json
    end
    env.response.content_type = "application/json"
    result
  end
end
