module Renders
  extend self

  def robots(
    host : String,
    scheme : String
  ) : String
    ECR.render "templates/robots.txt"
  end
end
