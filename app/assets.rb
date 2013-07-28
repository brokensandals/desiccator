require 'sprockets'

class Desiccator < Sinatra::Base

  set :assets, Sprockets::Environment.new

  settings.assets.append_path 'assets/js'
  settings.assets.append_path 'assets/css'

  # Assets routes
  get '/javascripts/:file.js' do
    content_type 'application/javascript'
    settings.assets["#{params[:file]}.js"]
  end

  get '/stylesheets/:file.css' do
    content_type 'text/css'
    settings.assets["#{params[:file]}.css"]
  end

end