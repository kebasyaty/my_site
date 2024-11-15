module Services::Admin::Routes
  # Delete document list
  post "/admin/delete-doc-list" do |env|
    if env.session.string("csrf") != env.params.json["authenticity_token"].as(String)
      halt env, status_code: 403, response: "Forbidden"
    end
    lang_code : String = env.session.string("current_lang")
    auth = Globals::Auth.user_authenticated? env, lang_code
    authenticated? : Bool = auth[:is_authenticated] && auth[:is_admin]
    msg_err : String = ""

    if authenticated?
      model_key = env.params.json["model_key"].as(String)
      doc_hash_list = Array(String).from_json(env.params.json["doc_hash_list"].as(String))
      model_class = Globals::Extra::Tools.model_class(model_key)
      I18n.with_locale(lang_code) do
        if model_class.meta[:delete_doc?]
          doc_hash_list.each do |doc_hash|
            if BSON::ObjectId.validate(doc_hash)
              id = BSON::ObjectId.new(doc_hash)
              if model_class.delete_one({_id: id}).nil?
                msg_err = "ID: #{doc_hash}<br/>#{I18n.t(:doc_was_not_delete)}"
                break
              end
            else
              msg_err = "ID: #{doc_hash}<br/>#{I18n.t(:invalid_doc_id)}"
              break
            end
          end
        else
          msg_err = I18n.t(:forbidden_deleting_docs)
        end
      end
    end

    result = {
      is_authenticated: authenticated?,
      msg_err:          msg_err,
    }.to_json
    env.response.content_type = "application/json"
    result
  end
end
