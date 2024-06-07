module Vizbor::Services::Admin::Routes
  type ServiceList = [
    {
      service:     {title: String, icon: String},
      collections: [
        {
          title:     String,
          model_key: String,
          fields:    [{field: String, title: String}],
        },
      ],
    },
  ]
  # Get service list
  post "/admin/service-list" do |env|
    is_authenticated : Bool = false
    msg_err : String = ""

    if !(user = env.session.object?("user")).nil?
      user = user.as(UserStorableObject)
      if !user.username.empty? &&
         !user.hash.empty? && user.is_admin? && user.is_active?
        is_authenticated = true
      else
        msg_err = I18n.t(:auth_failed)
      end
    else
      msg_err = I18n.t(:auth_failed)
    end

    result = {
      is_authenticated: is_authenticated,
      logo:             "",
      brand:            "",
      slogan:           "",
      service_list:     "",
      msg_err:          msg_err,
    }.to_json
    env.response.content_type = "application/json"
    result
  end
end
