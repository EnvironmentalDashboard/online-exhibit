require "sinatra"
require "sinatra/namespace"
require "sinatra/reloader" if development?

def button_index (buttonslist, index)
  listlength = buttonslist.length
  index = index.to_i
  index = (index >= listlength ? 0: index)
  return index
end

def setup_exhibit()
  button_path = "config/#{params[:exhibit]}.json"
  halt 404, "No configuration exists for that presentation" unless File.file? button_path

  buttonslist = JSON.parse(File.read("config/#{params[:exhibit]}.json"), object_class: OpenStruct)
  @buttons = buttonslist[0]
  @initial = @buttons.find{|e| e.initial}
  @button_index = 0
  @exhibit = params[:exhibit]
end

def setup_buttons_initial()
  button_set_path = "config/#{params[:exhibit]}.json"

  halt 404, "No configuration exists for that presentation" unless File.file? button_set_path

  @exhibit = params[:exhibit]
  buttonslist = JSON.parse(File.read("config/#{params[:exhibit]}.json"), object_class: OpenStruct)
  index = params[:index] || 0
  @button_index= button_index(buttonslist, index)
  @buttons=buttonslist[@button_index]
  @initial = @buttons.find{|e| e.initial}
end

PREFIX = ENV["PATH_PREFIX"] ? "/#{ENV['PATH_PREFIX']}" : ""
set :static, false

namespace "#{PREFIX}" do
  # Define our own public pathing.
  get "/public/*" do
    filename = params[:splat].first

    if File.exist?("public/#{filename}")
      send_file "public/#{filename}"
    else
      halt 404, "No public file found"
    end
  end

  get "/:exhibit" do
    setup_exhibit()
    @buttons_html = erb :controller
    erb :exhibit

  end

  get "/:exhibit/buttons" do

    setup_buttons_initial()
    erb :controller

  end

  get "/:exhibit/initial" do

    setup_buttons_initial()
    @initial.pres_path

  end

end
