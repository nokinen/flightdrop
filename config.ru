require './drop'

configure do
  mime_type :kml, 'application/vnd.google-earth.kml+xml'
end

run Sinatra::Application