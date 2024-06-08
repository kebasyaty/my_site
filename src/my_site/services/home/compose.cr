# Service composition for menu structure of admin panel.
module Vizbor::Services::Home
  struct Compose < Vizbor::Composition::AdminPanelMenu
    def self.composition : Vizbor::Composition::Service
      # WARNING: Get icon name (for service) - https://materialdesignicons.com/
      {
        service:     {title: "Home", icon: "help"},
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
