# Service composition for menu structure of admin panel.
module Vizbor::Services::Home
  struct HomePage < Vizbor::Сomposition
    def self.composition : Vizbor::CompositionType
      # For example, look at 'compose.cr' in Vizbor::Services::Admin.
      # WARNING: Get icon name (for service) - https://materialdesignicons.com/
      {
        service:     {title: "Home Page", icon: "help"},
        collections: [
          {
            title:     "???",
            model_key: "???", # Vizbor::Services::<ServiceName>::Models::<ModelName>.full_model_name,
            fields:    [
              {field: "???", title: "???"},
            ],
          },
        ],
      }
    end
  end
end
