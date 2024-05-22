# Basic Routes
module Vizbor::Basic::Routes
  get "/" do
    "Hello World!"
  end

  get "/favicon.ico" do
    # ...
  end

  get "/favicons/:icon" do
    # ...
  end

  get "/robots.txt" do
    # ...
  end

  get "/sitemap.xml" do
    # ...
  end

  error 404 do
    "This is a customized 404 page."
  end
end
