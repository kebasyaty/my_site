# Service composition for the admin panel menu structure.
module Vizbor::Services::Admin::Compose
  composition = {
    service:     {title: "", icon: ""},
    collections: [
      {
        title:     "",
        model_key: "",
        fields:    [{field: "", title: ""}],
      },
    ],
  }
  Vizbor::Composition.add(composition)
end
