module Vizbor::Services::Admin::Models
  @[DynFork::Meta(
    service_name: "Admin",
    create_doc?: false,
    delete_doc?: false,
  )]
  struct SiteParameters < DynFork::Model
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
