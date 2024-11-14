module Services::Home::Models
  # Home page parameters.
  # WARNING: Use config/fixtures/HomePageParams.yml
  @[DynFork::Meta(
    service_name: "Home",
    fixture_name: "HomePageParams",
    create_doc?: false,
    delete_doc?: false,
  )]
  struct HomePageParams < DynFork::Model
    include Globals::Extra::InstanceMethods
    extend Globals::Extra::ClassMethods

    getter meta_title = DynFork::Fields::TextField.new(
      label: I18n.t(:meta_title),
      placeholder: I18n.t(:enter_meta_title),
      maxlength: 60,
      warning: [I18n.t(:for_meta_tag_title)],
    )
    getter meta_description = DynFork::Fields::TextField.new(
      label: I18n.t(:meta_description),
      placeholder: I18n.t(:enter_meta_description),
      maxlength: 300,
      warning: [I18n.t(:for_meta_tag_description)],
    )
  end
end
