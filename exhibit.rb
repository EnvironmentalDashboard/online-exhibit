require "sinatra"

set :environment, :development
require "sinatra/reloader" if development?

config = JSON.parse(File.read('config.json'))

puts config

get "/" do
  config.to_json
end
