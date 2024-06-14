module Vizbor::Services::Admin::Routes
  # Admin panel page
  get "/admin" do |env|
    if env.session.string?("current_lang").nil?
      env.session.string("current_lang", Vizbor::Settings.default_locale)
    end
    env.redirect "/admin/sign-in"
  end
end
