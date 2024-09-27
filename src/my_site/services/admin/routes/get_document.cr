module Services::Admin::Routes
  # Get document
  post "/admin/get-document" do |env|
    lang_code : String = env.session.string("current_lang")
    auth = Globals::Auth.user_authenticated? env, lang_code
    authenticated? : Bool = auth[:is_authenticated] && auth[:is_admin]

    if authenticated?
      model_key = env.params.json["model_key"].as(String)
      doc_hash = env.params.json["doc_hash"].as(String)
    end

    result = {
      is_authenticated: authenticated?,
    }.to_json
    env.response.content_type = "application/json"
    result
  end
end
