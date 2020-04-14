require "sinatra"
require "sinatra/reloader" if development?

config = JSON.parse(File.read("config.json"))

get "/" do
  "hi!!"
end
