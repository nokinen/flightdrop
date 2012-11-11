require "sinatra"
require "haml"
require "sass"
require "fdc"

get "/" do
  haml :drop, format: :html5
end

get "/stylesheet.css" do
  scss :stylesheet
end

post "/convert" do
end