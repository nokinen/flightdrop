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
  orig_filename = params[:filename]
  filename = File.basename(orig_filename, File.extname(orig_filename))
  
  converter = Fdc::Converter.new
  begin
    converter.parse_str data
    converter.compile name: filename, 
      gps: params[:gps], 
      clamp: params[:clamp], 
      extrude: params[:extrude]
  rescue => e
    flash[:notice] = "#{orig_filename} could not be converted: #{e.message}"
    redirect "/"
  end
  
  content_type :kml
  attachment filename
  converter.kml
  
end