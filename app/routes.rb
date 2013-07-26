class Desiccator < Sinatra::Base
  get '/' do
    slim :home
  end

  get '/users/:login/pulls' do
    slim :pulls, locals: {user: User.find_by_login(params[:login])}
  end

  get '/users/:login/settings' do
    return 404 unless user = MANAGER.sync_user(params[:login])
    slim :user_settings, locals: {user: user}
  end

  put '/users/:login/settings' do
    return 404 unless user = User.find_by_login(params[:login])
    user.update_attributes!(params[:user])
    redirect "/users/#{user.login}/settings"
  end

  post '/users/:login/crawl' do
    return 404 unless user = MANAGER.sync_user(params[:login])
    MANAGER.crawl(user.login)
    redirect "/users/#{user.login}/settings"
  end

  get '/repos/:owner/:name/settings' do
    return 404 unless user = User.find_by_login(params[:owner])
    return 404 unless repo = user.repos.find_by_name(params[:name])
    slim :repo_settings, locals: {repo: repo}
  end

  put '/repos/:owner/:name/settings' do
    return 404 unless user = User.find_by_login(params[:owner])
    return 404 unless repo = user.repos.find_by_name(params[:name])
    repo.update_attributes!(params[:repo])
    redirect "/repos/#{repo.path}/settings"
  end
end
