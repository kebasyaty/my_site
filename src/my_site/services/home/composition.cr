# Service composition for menu structure of admin panel.
module Vizbor::Services::Home
  struct HomePageParameters < Vizbor::MenuComposition
    def self.composition : Vizbor::MenuCompositionType?
      # WARNING: Get icon name (for service) - https://materialdesignicons.com/
      {
        service:     {title: I18n.t(:home_page_params), icon: "cog"},
        collections: [
          {
            title:     I18n.t(:params),
            model_key: Vizbor::Services::Home::Models::HomePageParams.full_model_name,
            fields:    [
              {field: "meta_title", title: I18n.t(:meta_title)},
              {field: "meta_description", title: I18n.t(:meta_description)},
            ],
          },
        ],
      }
    end
  end
end
