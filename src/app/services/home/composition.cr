# Service composition for menu structure of admin panel.
module Services::Home
  struct HomePage < Vizbor::MenuComposition
    def self.composition : Vizbor::MenuCompositionResult?
      # WARNING: Get icon name (for service) - https://materialdesignicons.com/
      # Empty example:
      # {
      #   service:     {title: "...", icon: "help"},
      #   collections: [
      #     {
      #       title:     "...",
      #       model_key: "...", # Vizbor::Services::<ServiceName>::Models::<ModelName>.full_model_name,
      #       fields:    [
      #         # WARNING: The first field is necessarily textual related to the name of the document.
      #         {field: "...", title: "..."},
      #       ],
      #     },
      #   ],
      # }
    end
  end
end
