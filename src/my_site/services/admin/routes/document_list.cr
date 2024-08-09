module Services::Admin::Routes
  # Get document list.
  post "/admin/document-list" do |env|
    lang_code : String = env.session.string("current_lang")
    auth = Globals::Auth.user_authenticated? env, lang_code
    authenticated? : Bool = auth[:is_authenticated] && auth[:is_admin]

    if authenticated?
      model_key = env.params.json["model_key"].as(String)
      model_class = Globals::Extra::Tools.model_class(model_key)
      filter : Hash(String, String | Int64 | Float64 | BSON::ObjectId | Nil)? = nil
      field_name_and_type_list = model_class.meta["field_name_and_type_list"]

      if object_id : BSON::ObjectId? = BSON::ObjectId.new(search_query)
        tmp_doc : Array(Hash(String, String)) = {"_id" => object_id.not_nil!}
        field_name_and_type_list.each do |field_name, type_name|
          if type_name == "TextField" || type_name == "HashField"
            tmp_doc << {field_name => object_id.not_nil!}
          end
        end
        filter = {"$or" => tmp_doc}
      else
        fields_name = env.params.json["fields_name"].as(Array(String))
        page_num = env.params.json["page_num"].as(UInt32)
        search_query = env.params.json["search_query"].as(String)
        limit = env.params.json["limit"].as(UInt32)
        sort = env.params.json["sort"].as(String)
        direct = env.params.json["direct"].as(String)
        categories = env.params.json["filter"].as(Globals::Extra::Tools::AdminFilter)
        #
        page_count : UInt32 = 1
        documents = [] of Array(BSON)
        #
        search_query_not_empty? : Bool = !search_query.empty?
        categories_not_empty? : Bool = !categories.empty?

        if search_query_not_empty? || categories_not_empty?
          search_pattern : Regex? = search_query_not_empty? ? /^#{search_query}$/i : nil
          tmp_doc_1 = Array(Hash(String, Regex)).new
          tmp_doc_2 = Array(Hash(String, Regex)).new
          text_fields_regex = /^(?:ColorField|EmailField|PhoneField|TextField|HashField|URLField|IPField)$/

          field_name_and_type_list.each do |field_name, type_name|
            if text_fields_regex.matches?(type_name)
              tmp_doc_1 << {field_name => search_pattern}
            end
            if categories_not_empty?
              # ...
            end
          end
        end
      end
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
