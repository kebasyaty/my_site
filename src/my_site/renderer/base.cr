module Vizbor::Renderer
  extend self

  def base(
    lang_code : String,
    contact_email,
    contact_phone,
    meta_title,
    meta_description,
    header : String,
    content : String,
    styles : Array(String),
    scripts : Array(String)
  ) : String
    ECR.render "views/layouts/base.html"
  end

  def base_header(
    brand,
    slogan
  ) : String
    ECR.render "views/base_header.html"
  end

  def base_content : String
    ECR.render "views/base_content.html"
  end
end
