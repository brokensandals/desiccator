class Desiccator < Sinatra::Base
  get '/' do
    slim :home
  end

  get '/users/:login/pulls' do
    slim :pulls, locals: {user: User.find_by_login(params[:login])}
  end

  get '/repos/:owner/:name' do
    return 404 unless user = User.find_by_login(params[:owner])
    return 404 unless repo = user.repos.find_by_name(params[:name])
    slim :repo, locals: {repo: repo}
  end

  put '/repos/:owner/:name' do
    return 404 unless user = User.find_by_login(params[:owner])
    return 404 unless repo = user.repos.find_by_name(params[:name])
    repo.update_attributes!(params[:repo])
    redirect "/repos/#{repo.path}"
  end
end
