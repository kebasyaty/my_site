module Services::Admin::Routes
  # Admin panel page
  get "/admin" do |env|
    lang_code : String = env.session.string("current_lang")
    auth = Globals::Auth.user_authenticated? env, lang_code
    authenticated? : Bool = auth[:is_authenticated] && auth[:is_admin]
    if authenticated?
      send_file env, "templates/admin/index.html"
    else
      env.redirect "/admin/sign-in"
    end
  end
end
