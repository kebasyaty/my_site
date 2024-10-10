module Services::Admin::Models
  @[DynFork::Meta(
    service_name: "Admin",
    delete_doc?: false,
  )]
  struct User < DynFork::Model
    include Globals::Extra::InstanceMethods
    extend Globals::Extra::ClassMethods

    getter username = DynFork::Fields::TextField.new(
      label: I18n.t(:username),
      placeholder: I18n.t(:enter_your_username),
      maxlength: 150,
      regex: "^[a-zA-Z0-9_]+$", # do not use `.` and `+` chars
      regex_err_msg: I18n.t(
      "allowed_chars.interpolation",
      chars: "a-z A-Z 0-9 _"
    ),
      hint: I18n.t(
        "allowed_chars.interpolation",
        chars: "a-z A-Z 0-9 _"
      ),
      required: true,
      unique: true
    )
    getter avatar = DynFork::Fields::ImageField.new(
      label: I18n.t(:avatar),
      placeholder: I18n.t(:upload_your_photo),
      target_dir: "users/avatars",
      default: "public/media/default/no_avatar.png",
      thumbnails: [{"xs", 64}, {"sm", 128}, {"md", 256}, {"lg", 512}],
      # NOTE: 1 MB = 1048576 Bytes (in binary).
      maxsize: 524288, # 0.5 MB
      hint: I18n.t(
      "max_size.interpolation",
      size: "1 MB"
    ),
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
      label: I18n.t(:phone_number),
      placeholder: I18n.t(:enter_your_phone_number),
      unique: true,
    )
    getter password = DynFork::Fields::PasswordField.new(
      label: I18n.t(:password),
      placeholder: I18n.t(:enter_your_password),
      required: true,
    )
    getter confirm_password = DynFork::Fields::PasswordField.new(
      label: I18n.t(:confirm_password),
      placeholder: I18n.t(:repeat_your_password),
      ignored: true
    )
    getter is_admin = DynFork::Fields::BoolField.new(
      label: I18n.t(:is_admin),
      default: false,
      hint: I18n.t(:can_this_user_access_admin_panel),
    )
    getter is_active = DynFork::Fields::BoolField.new(
      label: I18n.t(:is_active),
      default: false,
      hint: I18n.t(:is_this_an_active_account),
    )
    getter last_login = DynFork::Fields::DateTimeField.new(
      label: I18n.t(:last_login),
      disabled: true,
      hint: I18n.t(:datetime_of_user_last_login),
      hide: true,
    )
    getter slug = DynFork::Fields::SlugField.new(
      label: I18n.t(:slug),
      slug_sources: ["username"],
      disabled: true,
      hide: true,
    )

    # Additional validation (starts automatically)
    private def add_validation : Hash(String, String)
      error_map = Hash(String, String).new
      # Get clean data.
      password : String? = @password.value?
      confirm_password : String? = @confirm_password.value?
      # Fields validation.
      if password != confirm_password
        error_map["confirm_password"] = I18n.t(:pass_does_not_match)
      end
      error_map
    end

    # Run indexing (starts automatically)
    def self.indexing
      self.create_indexes([
        {
          keys:    {"username": 1},
          options: {name: "username_Idx"},
        },
        {
          keys:    {"email": 1},
          options: {name: "email_Idx"},
        },
      ])
    end
  end
end
