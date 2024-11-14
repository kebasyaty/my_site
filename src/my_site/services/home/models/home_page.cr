module Services::Home::Models
  # Home page parameters.
  # WARNING: Use config/fixtures/HomePage.yml
  @[DynFork::Meta(
    service_name: "Home",
    fixture_name: "HomePage",
    create_doc?: false,
    delete_doc?: false,
  )]
  struct HomePage < DynFork::Model
    include Globals::Extra::InstanceMethods
    extend Globals::Extra::ClassMethods

    getter title = DynFork::Fields::TextField.new(
      label: I18n.t(:title),
      placeholder: I18n.t(:enter_title),
      maxlength: 60,
      required: true,
      unique: true,
      warning: [I18n.t(:recommended_not_change_title)],
    )

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
