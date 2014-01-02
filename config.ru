require File.expand_path('../app', __FILE__)

SCHEDULER = Rufus::Scheduler.new
SCHEDULER.every CRAWL_INTERVAL, first_in: '1s', overlap: false do
  User.where(crawl_repos: true).find_each do |user|
    MANAGER.crawl(user.login)
  end
  ActiveRecord::Base.clear_active_connections! # TODO is this safe? does it interfere with the request threads
end

run Desiccator
