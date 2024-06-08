# Service composition for the admin panel menu structure.
module Vizbor::Services::Admin::Compose
  composition = {
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
  Vizbor::Composition.add(composition)
end
