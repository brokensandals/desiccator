class Desiccator < Sinatra::Base
  require 'sinatra/reloader' if development?

  register Sinatra::ActiveRecordExtension
  set :database, {adapter: 'sqlite3', database: 'db.sqlite3'}
  set :views, File.dirname(__FILE__) + '/../views'

  get '/' do
    slim :home
  end

  get '/users/:login/pulls' do
    slim :pulls, locals: {user: User.find_by_login(params[:login])}
  end
end
