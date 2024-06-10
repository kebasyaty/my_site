module Vizbor::Services::Admin::Models
  @[DynFork::Meta(
    service_name: "Admin",
    create_doc?: false,
    delete_doc?: false,
  )]
  struct SiteParameters < DynFork::Model
    getter email = DynFork::Fields::EmailField.new(
      label: I18n.t(:email),
      placeholder: I18n.t(:enter_your_email),
      maxlength: 320,
      required: true,
      unique: true,
    )
    getter phone = DynFork::Fields::PhoneField.new(
      label: I18n.t(:phone_number),
      placeholder: I18n.t(:enter_your_phone_number),
    )
  end
end
