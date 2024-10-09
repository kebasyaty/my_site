module Services::Admin::Routes
  # Get a list of services for menu items, for admin panal.
  post "/admin/service-list" do |env|
    lang_code : String = env.session.string("current_lang")
    auth = Globals::Auth.user_authenticated? env, lang_code
    authenticated? : Bool = auth[:is_authenticated] && auth[:is_admin]

    result : String? = nil
    I18n.with_locale(lang_code) do
      result = {
        is_authenticated: authenticated?,
        service_list:     if authenticated?
          Vizbor::MenuComposition.get
        else
          [] of Vizbor::MenuCompositionResult
        end,
      }.to_json
    end
    env.response.content_type = "application/json"
    result
  end
end
