module Services::Home::Renders
  extend self

  def login_content : String
    ECR.render "templates/login.html"
  end
end
