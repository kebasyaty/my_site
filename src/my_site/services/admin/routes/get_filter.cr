module Services::Admin::Routes
  # Get filter by categories (сategory - field with parameter `choices`).
  post "/admin/get-filter" do |env|
    lang_code : String = env.session.string("current_lang")
    auth = Globals::Auth.user_authenticated? env, lang_code
    authenticated? : Bool = auth[:is_authenticated] && auth[:is_admin]
    #
    model_key : String = env.params.json["model_key"].as(String)
    model_instance = Globals::Extra::Tools.model_instance(model_key)
    filter = model_instance.admin_filter

    result = {
      is_authenticated: authenticated?,
      filter:           filter,
    }.to_json
    env.response.content_type = "application/json"
    result
  end
end
