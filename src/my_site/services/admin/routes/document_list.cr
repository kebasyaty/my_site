module Services::Admin::Routes
  # Get document list.
  post "/admin/document-list" do |env|
    lang_code : String = env.session.string("current_lang")
    auth = Globals::Auth.user_authenticated? env, lang_code
    authenticated? : Bool = auth[:is_authenticated] && auth[:is_admin]
    #
    model_key = env.params.json["model_key"].as(String)
    model = Globals::Extra::Tools.model_instance(model_key)

    if authenticated?
      fields_name = env.params.json["fields_name"].as(Array(String))
      page_num = env.params.json["page_num"].as(UInt32)
      search_query = env.params.json["search_query"].as(String)
      limit = env.params.json["limit"].as(UInt32)
      sort = env.params.json["sort"].as(String)
      direct = env.params.json["direct"].as(String)
      filter = env.params.json["filter"].as(Globals::Extra::Tools::AdminFilter)
      #
      page_count : UInt32 = 1
      documents = [] of Array(BSON)
    end

    result : String? = nil
    I18n.with_locale(lang_code) do
      result = {
        is_authenticated: authenticated?,
      }.to_json
    end
    env.response.content_type = "application/json"
    result
  end
end
