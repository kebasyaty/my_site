# Service composition for menu structure of admin panel.
module Vizbor::Services::Admin
  struct Accounts < Vizbor::MenuComposition
    def self.composition : Vizbor::MenuCompositionType?
      # WARNING: Get icon name (for service) - https://materialdesignicons.com/
      {
        service:     {title: I18n.t(:accounts), icon: "account-multiple"},
        collections: [
          {
            title:     I18n.t(:users),
            model_key: Vizbor::Services::Admin::Models::User.full_model_name,
            fields:    [
              {field: "username", title: I18n.t(:nickname)},
              {field: "avatar", title: I18n.t(:avatar)},
              {field: "first_name", title: I18n.t(:first_name)},
              {field: "last_name", title: I18n.t(:last_name)},
              {field: "email", title: I18n.t(:email)},
              {field: "phone", title: I18n.t(:phone)},
              {field: "is_admin", title: I18n.t(:is_admin)},
              {field: "is_active", title: I18n.t(:is_active)},
            ],
          },
        ],
      }
    end
  end

  struct SiteParameters < Vizbor::MenuComposition
    def self.composition : Vizbor::MenuCompositionType?
      # WARNING: Get icon name (for service) - https://materialdesignicons.com/
      {
        service:     {title: I18n.t(:site_parameters), icon: "cog"},
        collections: [
          {
            title:     I18n.t(:basic_settings),
            model_key: Vizbor::Services::Admin::Models::BasicSettings.full_model_name,
            fields:    [
              {field: "brand", title: I18n.t(:brand)},
              {field: "slogan", title: I18n.t(:slogan)},
              {field: "email", title: I18n.t(:email)},
              {field: "phone", title: I18n.t(:phone)},
            ],
          },
          {
            title:     I18n.t(:basic_settings),
            model_key: Vizbor::Services::Home::Models::HomePageSettings.full_model_name,
            fields:    [
              {field: "meta_title", title: I18n.t(:meta_title)},
              {field: "meta_description", title: I18n.t(:meta_description)},
            ],
          },
        ],
      }
    end
  end
end
