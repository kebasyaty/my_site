module Vizbor::Renderer
  extend self

  def base(
    lang_code : String,
    brand,
    slogan,
    contact_email,
    contact_phone,
    meta_title,
    meta_description,
    content : String,
    styles : Array(String),
    scripts : Array(String)
  ) : String
    ECR.render "views/layouts/base.html"
  end
end
