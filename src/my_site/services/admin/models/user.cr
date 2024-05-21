module Vizbor::Services::Admin
  @[DynFork::Meta(
    service_name: "Admin",
    delete_doc?: false,
  )]
  struct User < DynFork::Model
    getter username = DynFork::Fields::TextField.new(
      label: "Username",
      placeholder: "Enter your username",
      maxlength: 150,
      minlength: 1,
      regex: "^[a-zA-Z0-9_@.+]$",
      regex_err_msg: I18n.t(
        "allowed_chars.interpolation",
        chars: "a-z A-Z 0-9 _ @ . +"
      ),
      required: true,
      unique: true
    )
    getter email = DynFork::Fields::EmailField.new(
      label: "E-mail",
      placeholder: "Enter your email",
      maxlength: 320,
      required: true,
      unique: true,
    )
  end
end
