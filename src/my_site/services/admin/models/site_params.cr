module Vizbor::Services::Admin::Models
  @[DynFork::Meta(
    service_name: "Admin",
    fixture_name: "SiteParameters",
    create_doc?: false,
    delete_doc?: false,
  )]
  struct SiteParameters < DynFork::Model
    getter brand = DynFork::Fields::TextField.new(
      label: I18n.t(:brand),
      placeholder: I18n.t(:enter_your_company_name),
    )
    getter slogan = DynFork::Fields::TextField.new(
      label: I18n.t(:slogan),
      placeholder: I18n.t(:enter_your_company_slogan),
    )
    getter email = DynFork::Fields::EmailField.new(
      label: I18n.t(:email_for_feedback),
      placeholder: I18n.t(:enter_email),
      maxlength: 320,
    )
    getter phone = DynFork::Fields::PhoneField.new(
      label: I18n.t(:phone_for_feedback),
      placeholder: I18n.t(:enter_phone_number),
    )
  end
end
