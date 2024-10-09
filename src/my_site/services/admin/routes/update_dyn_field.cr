module Services::Admin::Routes
  # Add or delete dynamic element (Unit).
  # NOTE: Management for `choices` parameter in dynamic field types.
  post "/admin/update-dyn-field" do |env|
    lang_code : String = env.session.string("current_lang")
    auth = Globals::Auth.user_authenticated? env, lang_code
    authenticated? : Bool = auth[:is_authenticated] && auth[:is_admin]
    msg_err : String = ""

    if authenticated?
      model_key = env.params.json["model_key"].as(String)
      unit = DynFork::Globals::Unit.from_json(env.params.json["unit"].as(String))
      model_class = Globals::Extra::Tools.model_class(model_key)
      model_class.unit_manager unit
    end

    result = {
      is_authenticated: authenticated?,
      msg_err:          msg_err,
    }.to_json
    env.response.content_type = "application/json"
    result
  end
end
