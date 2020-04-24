require "sinatra"
require "sinatra/reloader" if development?

get "/:exhibit" do
  button_path = "config/#{params[:exhibit]}.json"

  halt 404, "No configuration exists for that presentation" unless File.file? button_path

  @buttonslist = JSON.parse(File.read("config/#{params[:exhibit]}.json"), object_class: OpenStruct)
  @buttons = @buttonslist[0]
  @initial = @buttons.find{|e| e.initial}
  @button_index = 0
  @exhibit = params[:exhibit]
  @buttons_html = erb :controller
  puts @buttons
  puts @initial
  erb :exhibit
end

get "/:exhibit/buttons" do

  button_path = "config/#{params[:exhibit]}.json"

  halt 404, "No configuration exists for that presentation" unless File.file? button_path

  @exhibit = params[:exhibit]
  @buttonslist = JSON.parse(File.read("config/#{params[:exhibit]}.json"), object_class: OpenStruct)
  @button_index = params[:index] || 0
  @listlength = @buttonslist.length
  @button_index = @button_index.to_i
  @button_index = (@button_index>=@listlength? 0: @button_index)
  @buttons = @buttonslist[@button_index]
  @initial = @buttons.find{|e| e.initial}

  erb :controller

end

get "/:exhibit/initial" do

  button_path = "config/#{params[:exhibit]}.json"

  halt 404, "No configuration exists for that presentation" unless File.file? button_path

  @buttonslist = JSON.parse(File.read("config/#{params[:exhibit]}.json"), object_class: OpenStruct)
  @button_index = params[:index] || 0
  @listlength = @buttonslist.length
  @button_index = @button_index.to_i
  @button_index = (@button_index>=@listlength? 0: @button_index)
  @buttons = @buttonslist[@button_index]
  @initial = @buttons.find{|e| e.initial}

  @initial.pres_path
end
