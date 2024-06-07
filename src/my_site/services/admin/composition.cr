# Service structure for the admin panel.
module Vizbor::Services::Admin::Сomposition
  type ServiceСomposition = {
    service:     {title: String, icon: String},
    collections: [
      {
        title:     String,
        model_key: String,
        fields:    [{field: String, title: String}],
      },
    ],
  }

  type ServiceListСomposition = [ServiceСomposition]
end
