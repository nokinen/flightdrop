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
  filename = File.basename(filename, File.extname(filename))
  
  converter = Fdc::Converter.new
  begin
    converter.parse_str data
    converter.compile name: filename
  rescue => e
    flash[:notice] = e.message
    redirect "/"
  end
  
  content_type :kml
  attachment filename
  converter.kml
  
end