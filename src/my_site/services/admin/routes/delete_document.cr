module Services::Admin::Routes
  # Delete document
  post "/admin/delete-document" do |env|
    lang_code : String = env.session.string("current_lang")
    auth = Globals::Auth.user_authenticated? env, lang_code
    authenticated? : Bool = auth[:is_authenticated] && auth[:is_admin]
    msg_err : String = ""

    if authenticated?
      model_key = env.params.json["model_key"].as(String)
      doc_hash = env.params.json["doc_hash"].as(String)
      model_class = Globals::Extra::Tools.model_class(model_key)
      I18n.with_locale(lang_code) do
        if !model_class.meta[:delete_doc?]
          msg_err = I18n.t(:forbidden_deleting_docs)
        elsif BSON::ObjectId.validate(doc_hash)
          id = BSON::ObjectId.new(doc_hash)
          if model_class.delete_one({_id: id}).nil?
            msg_err = I18n.t(:doc_was_not_delete)
          end
        else
          msg_err = I18n.t(:invalid_doc_id)
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
