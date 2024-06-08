# Service composition for menu structure of admin panel.
module Vizbor::Services::Admin
  struct Compose < Vizbor::Composition::AdminPanelMenu
    def self.composition : Vizbor::Composition::Service
      # WARNING: Get icon name (for service) - https://materialdesignicons.com/
      {
        service:     {title: "Accounts", icon: "account-multiple"},
        collections: [
          {
            title:     "Users",
            model_key: Vizbor::Services::Admin::Models::User.full_model_name,
            fields:    [
              {field: "username", title: "Nickname"},
              {field: "avatar", title: "Avatar"},
              {field: "first_name", title: "First name"},
              {field: "last_name", title: "Last name"},
              {field: "email", title: "E-mail"},
              {field: "phone", title: "Phone"},
              {field: "is_admin", title: "Admin?"},
              {field: "is_active", title: "Active?"},
            ],
          },
        ],
      }
    end
  end
end
