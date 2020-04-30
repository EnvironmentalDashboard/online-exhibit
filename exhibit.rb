require "sinatra"
require "sinatra/namespace"
require "sinatra/reloader" if development?

def setup_exhibit
  button_path = "config/#{params[:exhibit]}.json"
  halt 404, "No configuration exists for that presentation" unless File.file? button_path

  buttonslist = JSON.parse(File.read(button_path), object_class: OpenStruct)
  @buttons = buttonslist[0]
  @initial = @buttons.find{|e| e.initial}
  @button_index = 0
  @exhibit = params[:exhibit]

  buttonslist
end

def setup_buttons_initial
  buttonslist =setup_exhibit
  @button_index = params[:index] || 0
  listlength = buttonslist.length
  @button_index = @button_index.to_i
  @button_index = (@button_index >= listlength ? 0: @button_index)
  @buttons = buttonslist[@button_index]
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
    setup_exhibit
    @buttons_html = erb :controller
    erb :exhibit
  end

  get "/:exhibit/buttons" do
    setup_buttons_initial
    erb :controller
  end

  get "/:exhibit/initial" do
    setup_buttons_initial
    @initial.pres_path
  end

end
