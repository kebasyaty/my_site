module Services::Admin::Routes
  # Get document
  post "/admin/get-document" do |env|
    if env.session.string("csrf") != env.params.json["authenticity_token"].as(String)
      halt env, status_code: 403, response: "Forbidden"
    end
    lang_code : String = env.session.string("current_lang")
    auth = Globals::Auth.user_authenticated? env, lang_code
    authenticated? : Bool = auth[:is_authenticated] && auth[:is_admin]
    document = nil
    msg_err : String = ""

    if authenticated?
      model_key = env.params.json["model_key"].as(String)
      doc_hash = env.params.json["doc_hash"].as(String)
      model_class = Globals::Extra::Tools.model_class(model_key)
      I18n.with_locale(lang_code) do
        if doc_hash.empty?
          document = model_class.new
        elsif BSON::ObjectId.validate(doc_hash)
          id = BSON::ObjectId.new(doc_hash)
          if (document = model_class.find_one_to_instance({_id: id})).nil?
            msg_err = I18n.t(:doc_is_missing)
          end
        else
          msg_err = I18n.t(:invalid_doc_id)
        end
      end
    end

    result = {
      is_authenticated: authenticated?,
      document:         document,
      msg_err:          msg_err,
    }.to_json
    env.response.content_type = "application/json"
    result
  end
end
