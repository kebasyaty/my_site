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
    ECR.render "views/base/header.html"
  end

  def base_content : String
    ECR.render "views/base/content.html"
  end

  def base_footer : String
    ECR.render "views/base/footer.html"
  end
end
