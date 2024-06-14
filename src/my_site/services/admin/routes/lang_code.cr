module Vizbor::Services::Admin::Routes
  # Get language code
  get "/admin/lang-code" do |env|
    result = {
      lang_code: env.session.string("current_lang"),
      msg_err:   "",
    }.to_json
    env.response.content_type = "application/json"
    result
  end
end
