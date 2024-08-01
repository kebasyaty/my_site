module Services::Admin::Routes
  # Get service list
  post "/admin/service-list" do |env|
    lang_code : String = env.session.string("current_lang")

    result : String? = nil
    I18n.with_locale(lang_code) do
      site_params = Services::Admin::Models::SiteParams.find_one_to_hash.not_nil!
      result = {
        brand:        site_params["brand"],
        slogan:       site_params["slogan"],
        service_list: Vizbor::MenuComposition.get,
        msg_err:      "",
      }.to_json
    end
    env.response.content_type = "application/json"
    result
  end
end
