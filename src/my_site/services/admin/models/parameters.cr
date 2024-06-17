module Vizbor::Services::Admin::Models
  # Basic site parameters
  @[DynFork::Meta(
    service_name: "Admin",
    fixture_name: "SiteParams",
    create_doc?: false,
    delete_doc?: false,
  )]
  struct SiteParams < DynFork::Model
    getter brand = DynFork::Fields::TextField.new(
      label: I18n.t(:brand),
      placeholder: I18n.t(:enter_your_company_name),
    )
    getter slogan = DynFork::Fields::TextField.new(
      label: I18n.t(:slogan),
      placeholder: I18n.t(:enter_your_company_slogan),
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
  end
end
