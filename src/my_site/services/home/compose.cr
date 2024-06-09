# Service composition for menu structure of admin panel.
module Vizbor::Services::Home
  struct HomePage < Vizbor::Compose
    def self.composition : Vizbor::Composition
      # WARNING: Get icon name (for service) - https://materialdesignicons.com/
      # Example:
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
