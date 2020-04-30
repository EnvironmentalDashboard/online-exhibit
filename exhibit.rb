require "sinatra"
require "sinatra/reloader" if development?


def button_index (buttonslist, index)
  listlength = buttonslist.length
  index = index.to_i
  index = (index >= listlength ? 0: index)
  return index
end

def setup()
  buttonslist = JSON.parse(File.read("config/#{params[:exhibit]}.json"), object_class: OpenStruct)
  vars={}



get "/:exhibit" do
  button_path = "config/#{params[:exhibit]}.json"

  halt 404, "No configuration exists for that presentation" unless File.file? button_path

  buttonslist = JSON.parse(File.read("config/#{params[:exhibit]}.json"), object_class: OpenStruct)
  @buttons = buttonslist[0]
  @initial = @buttons.find{|e| e.initial}
  @button_index = 0
  @exhibit = params[:exhibit]
  @buttons_html = erb :controller
  erb :exhibit
end

get "/:exhibit/buttons" do

  button_set_path = "config/#{params[:exhibit]}.json"

  halt 404, "No configuration exists for that presentation" unless File.file? button_set_path

  @exhibit = params[:exhibit]
  buttonslist = JSON.parse(File.read("config/#{params[:exhibit]}.json"), object_class: OpenStruct)
  index = params[:index] || 0
  @button_index= button_index(buttonslist, index)
  @buttons=buttonslist[@button_index]
  @initial = @buttons.find{|e| e.initial}

  erb :controller

end

get "/:exhibit/initial" do

  button_set_path = "config/#{params[:exhibit]}.json"

  halt 404, "No configuration exists for that presentation" unless File.file? button_set_path

  buttonslist = JSON.parse(File.read("config/#{params[:exhibit]}.json"), object_class: OpenStruct)
  index = params[:index] || 0
  @button_index= button_index(buttonslist, index)
  @buttons=buttonslist[@button_index]
  @initial = @buttons.find{|e| e.initial}

  @initial.pres_path
end
