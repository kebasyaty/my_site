module Globals::Renders
  extend self

  def login_content(env : HTTP::Server::Context) : String
    ECR.render "templates/login.html"
  end
end
