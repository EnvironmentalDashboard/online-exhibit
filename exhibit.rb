require "sinatra"
require "sinatra/reloader" if development?

get "/:exhibit" do
  @buttons = JSON.parse(File.read("config/#{params[:exhibit]}.json"), object_class: OpenStruct)
  erb :exhibit
end
