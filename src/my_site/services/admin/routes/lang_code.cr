module Vizbor::Services::Admin::Routes
  # Get language code
  get "/admin/lang-code" do |env|
    lang_code = {
      lang_code: Vizbor::Settings.default_locale,
      msg_err:   "",
    }.to_json
    env.response.content_type = "application/json"
    lang_code
  end
end
