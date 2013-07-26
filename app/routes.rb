class Desiccator < Sinatra::Base
  get '/' do
    slim :home
  end

  get '/users/:login/pulls' do
    slim :pulls, locals: {user: User.find_by_login(params[:login])}
  end
end
