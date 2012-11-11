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
  
  data = params[:data]
  filename = params[:filename]
  filename = File.basename(filename, File.extname(filename))
  
  converter = Fdc::Converter.new
  converter.parse_str data
  converter.compile name: filename
  
  content_type :kml
  attachment filename
  converter.kml
  
end