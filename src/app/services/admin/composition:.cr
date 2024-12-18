# Service composition for menu structure for admin panel.
module Services::Admin
  struct Accounts < Vizbor::MenuComposition
    def self.composition : Vizbor::MenuCompositionResult?
      # WARNING: Get icon name (for service) - https://materialdesignicons.com/
      {
        service:     {title: I18n.t(:accounts), icon: "account-multiple"},
        collections: [
          {
            title:     I18n.t(:users),
            model_key: Services::Admin::Models::User.full_model_name,
            fields:    [
              # WARNING: The first field is necessarily textual related to the name of the document.
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

  struct Settings < Vizbor::MenuComposition
    def self.composition : Vizbor::MenuCompositionResult?
      # WARNING: Get icon name (for service) - https://materialdesignicons.com/
      {
        service:     {title: I18n.t(:settings), icon: "cog"},
        collections: [
          {
            title:     I18n.t(:general),
            model_key: Services::Admin::Models::GeneralParameters.full_model_name,
            fields:    [
              # WARNING: The first field is necessarily textual related to the name of the document.
              {field: "title", title: I18n.t(:title)},
              {field: "brand", title: I18n.t(:brand)},
              {field: "slogan", title: I18n.t(:slogan)},
              {field: "logo", title: I18n.t(:logo)},
              {field: "contact_email", title: I18n.t(:email)},
              {field: "contact_phone", title: I18n.t(:phone)},
            ],
          },
          {
            title:     I18n.t(:home_page),
            model_key: Services::Home::Models::HomePage.full_model_name,
            fields:    [
              # WARNING: The first field is necessarily textual related to the name of the document.
              {field: "title", title: I18n.t(:title)},
              {field: "meta_title", title: I18n.t(:meta_title)},
            ],
          },
        ],
      }
    end
  end
end
