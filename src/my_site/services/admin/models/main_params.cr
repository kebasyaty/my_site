module Services::Admin::Models
  # Main site parameters.
  # WARNING: Use config/fixtures/MainParams.yml
  @[DynFork::Meta(
    service_name: "Admin",
    fixture_name: "MainParams",
    create_doc?: false,
    delete_doc?: false,
  )]
  struct MainParams < DynFork::Model
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
    getter logo = DynFork::Fields::ImageField.new(
      label: I18n.t(:logo),
      placeholder: I18n.t(:upload_logo),
      target_dir: "site_params/logos",
      default: "public/media/default/vizbor.png",
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
      default: "public/media/default/building_site.jpg",
      # NOTE: 1 MB = 1048576 Bytes (in binary).
      maxsize: 1048576, # 1024 KB
      warning: [I18n.t(:bg_img_admin_panel),
                I18n.t(:apply_change_after_saving),
                I18n.t(
                  "max_size.interpolation",
                  size: "1 MB"
                )],
    )
    getter bg_opacity = DynFork::Fields::F64Field.new(
      label: I18n.t(:level_transparency),
      input_type: "range",
      default: 0.8,
      step: 0.1,
      max: 0.9,
      min: 0,
      warning: [I18n.t(:level_transparency_bg_img_admin_panel),
                I18n.t(:apply_change_after_saving)],
    )
  end
end
