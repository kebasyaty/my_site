module Vizbor::Renders
  extend self

  def base(
    lang_code : String,
    brand : String,
    slogan : String,
    contact_email : String,
    contact_phone : String,
    meta_title : String,
    meta_description : String,
    content : String,
    styles : Array(String),
    scripts : Array(String)
  ) : String
    ECR.render "views/layouts/base.html.ecr"
  end
end
