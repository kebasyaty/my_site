module Services::Admin::Routes
  # Get data to filter by category (сategory - selection type fields).
  post "/admin/data-filters" do |env|
    lang_code : String = env.session.string("current_lang")
    auth = Globals::Auth.user_authenticated? env, lang_code
    authenticated? : Bool = auth[:is_authenticated] && auth[:is_admin]
    model_key : String = env.params.json["model_key"].as(String)
    filters : Array(String) = [] of String
    msg_err : String = ""

    result : String? = nil
    I18n.with_locale(lang_code) do
      # site_params = Services::Admin::Models::SiteParams.find_one_to_hash.not_nil!
      result = {
        is_authenticated: authenticated?,
        filters:          filters,
        msg_err:          msg_err,
      }.to_json
    end
    env.response.content_type = "application/json"
    result
  end
end
