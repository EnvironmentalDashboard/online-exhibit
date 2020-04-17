require "sinatra"
require "sinatra/reloader" if development?

get "/:exhibit" do
  button_path = "config/#{params[:exhibit]}.json"

  halt 404, "No configuration exists for that presentation" unless File.file? button_path

  @buttons = JSON.parse(File.read("config/#{params[:exhibit]}.json"), object_class: OpenStruct)
  @initial = @buttons.find{|e| e.initial}
  puts @buttons
  puts @initial
  erb :exhibit
end
