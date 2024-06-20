module Renders
  extend self

  def robots(
    host : String,
    scheme : String
  ) : String
    ECR.render "templates/robots.txt.ecr"
  end
end
