module Services::Admin::Models
  # Basic site parameters
  @[DynFork::Meta(
    service_name: "Admin",
    fixture_name: "SiteParams",
    create_doc?: false,
    delete_doc?: false,
  )]
  struct SiteParams < DynFork::Model
    include Globals::Extra::InstanceMethods
    extend Globals::Extra::ClassMethods

    getter brand = DynFork::Fields::TextField.new(
      label: I18n.t(:brand),
      placeholder: I18n.t(:enter_your_company_name),
    )
    getter slogan = DynFork::Fields::TextField.new(
      label: I18n.t(:slogan),
      placeholder: I18n.t(:enter_your_company_slogan),
    )
    getter meta_title = DynFork::Fields::TextField.new(
      label: I18n.t(:meta_title),
      placeholder: I18n.t(:enter_meta_title),
      maxlength: 60,
      hint: I18n.t(:for_meta_tag_title),
    )
    getter meta_description = DynFork::Fields::TextField.new(
      label: I18n.t(:meta_description),
      placeholder: I18n.t(:enter_meta_description),
      maxlength: 300,
      hint: I18n.t(:for_meta_tag_description),
    )
    getter contact_email = DynFork::Fields::EmailField.new(
      label: I18n.t(:email_for_feedback),
      placeholder: I18n.t(:enter_email),
      maxlength: 320,
    )
    getter contact_phone = DynFork::Fields::PhoneField.new(
      label: I18n.t(:phone_for_feedback),
      placeholder: I18n.t(:enter_phone_number),
    )
    getter dark_theme = DynFork::Fields::BoolField.new(
      label: I18n.t(:dark_theme),
      default: false,
      hint: I18n.t(:is_this_an_active_account),
    )
  end
end
