module Services::Admin::Routes
  # Get data to filter by category (сategory - selection type fields).
  post "/admin/data-filters" do |env|
    lang_code : String = env.session.string("current_lang")
    auth = Globals::Auth.user_authenticated? env, lang_code
    authenticated? : Bool = auth[:is_authenticated] && auth[:is_admin]
    model_key : String = env.params.json["model_key"].as(String)
    filters = [] of String

    if model = Globals::Extra::Tools.target_model(model_key)
      filters = model.not_nil!.data_filters
    end

    result : String? = nil
    I18n.with_locale(lang_code) do
      result = {
        is_authenticated: authenticated?,
        filters:          filters,
      }.to_json
    end
    env.response.content_type = "application/json"
    result
  end
end
