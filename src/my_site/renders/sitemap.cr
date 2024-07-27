module Globals::Renders
  extend self

  def sitemap(
    items : Array(NamedTuple(
      loc: String,
      lastmod: String,
      changefreq: String,
      priority: Float64,
    ))
  ) : String
    ECR.render "templates/sitemap.xml"
  end
end
