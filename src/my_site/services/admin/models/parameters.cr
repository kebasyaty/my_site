module Services::Admin::Models
  # Basic site parameters.
  # WARNING: Use config/fixtures/SiteParams.yml
  @[DynFork::Meta(
    service_name: "Admin",
    fixture_name: "SiteParams",
    create_doc?: false,
    delete_doc?: false,
  )]
  struct SiteParams < DynFork::Model
    include Globals::Extra::InstanceMethods
    extend Globals::Extra::ClassMethods

    getter logo = DynFork::Fields::ImageField.new(
      label: I18n.t(:logo),
      placeholder: I18n.t(:upload_logo),
      target_dir: "site_params/logos",
      default: "public/media/default/no_logo.png",
      thumbnails: [{"xs", 64}, {"sm", 128}, {"md", 256}, {"lg", 512}],
      # NOTE: 1 MB = 1048576 Bytes (in binary).
      maxsize: 524288, # 512 KB
      warning: [I18n.t(
      "max_size.interpolation",
      size: "512 KB"
    )],
    )
    getter brand = DynFork::Fields::TextField.new(
      label: I18n.t(:brand),
      placeholder: I18n.t(:enter_your_company_name),
      warning: [I18n.t(:apply_change_after_saving)],
    )
    getter slogan = DynFork::Fields::TextField.new(
      label: I18n.t(:slogan),
      placeholder: I18n.t(:enter_your_company_slogan),
      warning: [I18n.t(:apply_change_after_saving)],
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
      default: true,
      warning: [I18n.t(:dark_or_light_theme)],
    )
    getter color_theme = DynFork::Fields::ChoiceTextField.new(
      label: I18n.t(:color_theme),
      default: "grey",
      choices: [
        {"grey", I18n.t(:grey)},
        {"blue", I18n.t(:blue)},
        {"teal", I18n.t(:teal)},
        {"pink", I18n.t(:pink)},
        {"green", I18n.t(:green)},
        {"purple", I18n.t(:purple)},
        {"orange", I18n.t(:orange)},
        {"brown", I18n.t(:brown)},
      ],
      warning: [I18n.t(:apply_change_after_saving)],
    )
    getter bg_image = DynFork::Fields::ImageField.new(
      label: I18n.t(:background_image),
      placeholder: I18n.t(:upload_image),
      target_dir: "site_params/background",
      # NOTE: 1 MB = 1048576 Bytes (in binary).
      maxsize: 1048576, # 1024 KB
      warning: [I18n.t(
      "max_size.interpolation",
      size: "1 MB"
    )],
    )
  end
end
