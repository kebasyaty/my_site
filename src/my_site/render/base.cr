module Vizbor::Render
  extend self

  def base(
    lang_code : String,
    meta_title,
    meta_description,
    header : String,
    content : String,
    footer : String,
    styles : Array(String),
    scripts : Array(String)
  ) : String
    ECR.render "templates/base/base.html"
  end

  def base_header(
    brand,
    slogan
  ) : String
    ECR.render "templates/base/header.html"
  end

  def base_content : String
    ECR.render "templates/base/content.html"
  end

  def base_footer(
    contact_email,
    contact_phone
  ) : String
    ECR.render "templates/base/footer.html"
  end
end
