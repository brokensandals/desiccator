require './config'

SCHEDULER = Rufus::Scheduler.start_new
MANAGER = Manager.new(GITHUB_API_BASE)
SCHEDULER.every CRAWL_INTERVAL, first_in: 0 do
  CRAWL_OWNERS.each do |owner|
    MANAGER.crawl(owner)
  end
  ActiveRecord::Base.clear_active_connections! # TODO is this safe? does it interfere with the request threads
end

run Desiccator
