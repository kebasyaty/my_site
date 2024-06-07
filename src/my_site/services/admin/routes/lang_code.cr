module Vizbor::Services::Admin::Routes
  # Get language code
  get "/admin/language-code" do |env|
    language_code = {
      language_code: Vizbor::Settings.default_locale,
      msg_err:       "",
    }.to_json
    env.response.content_type = "application/json"
    language_code
  end
end
