require "sinatra"
require "sinatra/reloader" if development?

config = JSON.parse(File.read("config.json"), object_class: OpenStruct)

get "/" do
  @buttons = config
  erb :exhibit
end
