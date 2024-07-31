# Service composition for menu structure of admin panel.
module Services::Home
  struct HomePage < Vizbor::MenuComposition
    def self.composition : Vizbor::MenuCompositionType?
      # WARNING: Get icon name (for service) - https://materialdesignicons.com/
      # Empty example:
      # {
      #   service:     {title: "???", icon: "help"},
      #   collections: [
      #     {
      #       title:     "???",
      #       model_key: "???", # Vizbor::Services::<ServiceName>::Models::<ModelName>.full_model_name,
      #       fields:    [
      #         {field: "???", title: "???"},
      #       ],
      #     },
      #   ],
      # }
    end
  end
end
