require "sinatra"
require "haml"
require "sass"
require "fdc"
require 'rack-flash'

enable :sessions
use Rack::Flash

get "/" do
  haml :drop, format: :html5
end

get "/stylesheet.css" do
  scss :stylesheet
end

post "/convert" do

  data = params[:data]
  filename = params[:filename]
  basename = File.basename(filename, File.extname(filename))
  
  converter = Fdc::Converter.new
  begin
    converter.parse_str data
    converter.compile name: basename, 
      gps: params[:gps], 
      clamp: params[:clamp], 
      extrude: params[:extrude]
  rescue => e
    flash[:notice] = "#{filename} could not be converted: #{e.message}"
    redirect "/"
  end
  
  content_type :kml
  attachment "#{basename}.kml"
  converter.kml
  
end