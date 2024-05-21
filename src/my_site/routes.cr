# Basic Routes
module Vizbor::Server::Routes
  get "/" do
    "Hello World!"
  end

  error 404 do
    "This is a customized 404 page."
  end
end
