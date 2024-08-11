module Services::Admin::Routes
  # Get document list.
  post "/admin/document-list" do |env|
    lang_code : String = env.session.string("current_lang")
    auth = Globals::Auth.user_authenticated? env, lang_code
    authenticated? : Bool = auth[:is_authenticated] && auth[:is_admin]

    if authenticated?
      model_key = env.params.json["model_key"].as(String)
      model_class = Globals::Extra::Tools.model_class(model_key)
      filter = nil
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
        categories = env.params.json["filter"].as(Hash(String, String | Array(String)))
        #
        page_count : UInt32 = 1
        documents = [] of Array(BSON)
        #
        field_name_and_type_list.select!(fields_name)
        #
        search_query_not_empty? : Bool = !search_query.empty?
        categories_not_empty? : Bool = !categories.empty?

        if search_query_not_empty? || categories_not_empty?
          search_pattern : Regex = /^#{search_query}$/i
          tmp_doc_1 = Array(Hash(String, Regex)).new
          tmp_doc_2 = Array(Hash(String, Hash(String, Globals::Extra::Tools::DataDynamicType?))).new

          field_name_and_type_list.each do |field_name, type_name|
            if search_query_not_empty? &&
               Globals::Extra::Tools.text_field_list.includes?(type_name)
              tmp_doc_1 << {field_name => search_pattern}
              next
            end
            if categories_not_empty?
              if category = categories[field_name]?
                value : String = category["value"]
                negation : Bool = category["negation"]
                val : Globals::Extra::Tools::DataDynamicType? = nil
                if type_name == "ChoiceTextField" || type_name == "ChoiceTextDynField"
                  tmp_doc_2 << negation ? {field_name => {"$ne" => value}} : {field_name => value}
                elsif type_name == "ChoiceTextMultField" || type_name == "ChoiceTextMultDynField"
                  tmp_doc_2 << negation ? {field_name: {"$not" => {"$in" => value}}} : {field_name => {"$all" => value}}
                elsif type_name == "ChoiceI64Field" || type_name == "ChoiceI64DynField"
                  val = value.to_s.to_i64
                  tmp_doc_2 << negation ? {field_name => {"$ne" => val}} : {field_name => val}
                elsif type_name == "ChoiceI64MultField" || type_name == "ChoiceI64MultDynField"
                  val = value.map(&.to_i64)
                  tmp_doc_2 << negation ? {field_name: {"$not" => {"$in": val}}} : {field_name => {"$all" => val}}
                elsif type_name == "ChoiceF64Field" || type_name == "ChoiceF64DynField"
                  val = value.to_s.to_f64
                  tmp_doc_2 << negation ? {field_name => {"$ne" => val}} : {field_name => val}
                elsif type_name == "ChoiceF64MultField" || type_name == "ChoiceF64MultDynField"
                  val = value.map(&.to_f64)
                  tmp_doc_2 << negation ? {field_name: {"$not" => {"$in" => val}}} : {field_name => {"$all" => val}}
                end
              end
            end
          end
          if search_query_not_empty? && categories_not_empty?
            filter = {"$or": tmp_doc_1, "$and": tmp_doc_2}
          elsif search_query_not_empty?
            filter = {"$or": tmp_doc_1}
          else
            filter = {"$and": tmp_doc_2}
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
