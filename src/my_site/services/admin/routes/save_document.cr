module Services::Admin::Routes
  # Save/Update the document
  post "/admin/save-document" do |env|
    lang_code : String = env.session.string("current_lang")
    auth = Globals::Auth.user_authenticated? env, lang_code
    authenticated? : Bool = auth[:is_authenticated] && auth[:is_admin]

    if authenticated?
      model_key = env.params.json["model_key"].as(String)
      instance = Globals::Extra::Tools.model_instance(model_key)
      data_form = Hash(String, String).from_json(env.params.json["data_form"].as(String))
      instance.admin_refrash_fields(data_form)
      instance.save
    end

    result = {
      is_authenticated: authenticated?,
      document:         instance,
    }.to_json
    env.response.content_type = "application/json"
    result
  end
end
