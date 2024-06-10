module Vizbor::Services::Admin::Routes
  # Get language code
  get "/admin/lang_code" do |env|
    lang_code = {
      language_code: Vizbor::Settings.default_locale,
      msg_err:       "",
    }.to_json
    env.response.content_type = "application/json"
    lang_code
  end
end
