module Services::Home::Renders
  extend self

  def home_content : String
    ECR.render "templates/base/content.html" # if necessary, add your template
  end
end
