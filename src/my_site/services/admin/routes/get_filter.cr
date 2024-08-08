module Services::Admin::Routes
  # Get filter by categories (сategory - field with parameter `choices`).
  post "/admin/get-filter" do |env|
    lang_code : String = env.session.string("current_lang")
    auth = Globals::Auth.user_authenticated? env, lang_code
    authenticated? : Bool = auth[:is_authenticated] && auth[:is_admin]
    #
    model_key : String = env.params.json["model_key"].as(String)
    filter = if model = Globals::Extra::Tools.target_model(model_key)
               model.not_nil!.new.admin_filter
             else
               raise Vizbor::Errors::Panic.new("There is no Model for `model_key`.")
             end

    result : String? = nil
    I18n.with_locale(lang_code) do
      result = {
        is_authenticated: authenticated?,
        filter:           filter,
      }.to_json
    end
    env.response.content_type = "application/json"
    result
  end
end
