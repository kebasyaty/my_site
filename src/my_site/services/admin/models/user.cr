module Vizbor::Services::Admin::Models
  @[DynFork::Meta(
    service_name: "Admin",
    delete_doc?: false,
  )]
  struct User < DynFork::Model
    getter username = DynFork::Fields::TextField.new(
      label: I18n.t(:username),
      placeholder: I18n.t(:enter_your_username),
      maxlength: 150,
      regex: "^[a-zA-Z0-9_@.+]+$",
      regex_err_msg: I18n.t(
        "allowed_chars.interpolation",
        chars: "a-z A-Z 0-9 _ @ . +"
      ),
      required: true,
      unique: true
    )
    getter avatar = DynFork::Fields::ImageField.new(
      label: I18n.t(:avatar),
      placeholder: I18n.t(:upload_your_photo),
      target_dir: "users/avatars",
      default: "public/media/default/no_avatar.png",
      thumbnails: [{"xs", 32}, {"sm", 64}, {"md", 128}, {"lg", 256}],
      # NOTE: 1 MB = 1048576 Bytes (in binary).
      maxsize: 2097152, # 2 MB
    )
    getter first_name = DynFork::Fields::TextField.new(
      label: I18n.t(:first_name),
      placeholder: I18n.t(:enter_your_first_name),
      maxlength: 150,
    )
    getter last_name = DynFork::Fields::TextField.new(
      label: I18n.t(:last_name),
      placeholder: I18n.t(:enter_your_last_name),
      maxlength: 150,
    )
    getter email = DynFork::Fields::EmailField.new(
      label: I18n.t(:email),
      placeholder: I18n.t(:enter_your_email),
      maxlength: 320,
      required: true,
      unique: true,
    )
    getter phone = DynFork::Fields::PhoneField.new(
      label: I18n.t(:phone),
      placeholder: I18n.t(:enter_your_phone_number),
    )
    getter password = DynFork::Fields::PasswordField.new(
      label: "Password",
      placeholder: "Enter your password",
      required: true,
    )
    getter confirm_password = DynFork::Fields::PasswordField.new(
      label: "Confirm password",
      ignored: true
    )
    getter is_admin = DynFork::Fields::BoolField.new(
      label: "is admin?",
      default: false,
      hint: "Can this user access the admin panel?",
    )
    getter is_active = DynFork::Fields::BoolField.new(
      label: "is active?",
      default: false,
      hint: "Is this an active account?",
    )
    getter last_login = DynFork::Fields::DateTimeField.new(
      label: "Last login",
      disabled: true,
      hint: "A datetime of the user’s last login.",
    )
    getter lang_code : DynFork::Fields::ChoiceTextField.new(
      label: "Language code",
      hint: "Choose a language that is convenient for you.",
      default: "en",
      choices: [
        {"en", "English"},
        {"ru", "Russian"},
        {"eo", "Esperanto"},
      ],
    )
    getter slug = DynFork::Fields::SlugField.new(
      label: "Slug",
      slug_sources: ["username"],
    )
  end
end
