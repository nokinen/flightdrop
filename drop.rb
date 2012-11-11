require "sinatra"
require "haml"
require "sass"
require "fdc"
require "debugger"

get "/" do
  haml :drop, format: :html5
end

get "/stylesheet.css" do
  scss :stylesheet
end

post "/convert" do
  
  converter = Fdc::Converter.new
  converter.parse_str params[:data]
  converter.compile name: "hello"
  
  content_type :kml
  attachment "hello"
  converter.kml
  
end