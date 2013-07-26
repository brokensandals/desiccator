require 'yaml'
CONFIG = YAML.load_file(File.dirname(__FILE__) + '/config.yaml')
GITHUB_BASE = CONFIG['github']
GITHUB_API_BASE = CONFIG['github_api']
CRAWL_INTERVAL = CONFIG['crawl_interval']
CRAWL_OWNERS = CONFIG['crawl_owners']

require 'rufus-scheduler'
require 'action_view'
require 'sinatra/activerecord'
require 'sinatra/base'
require 'slim'
require 'octokit'
require 'active_record'
require 'chronic_duration'
require 'business_time'

require File.expand_path('../lib/date_util', __FILE__)
require File.expand_path('../lib/manager', __FILE__)

require File.expand_path('../models/repo', __FILE__)
require File.expand_path('../models/review', __FILE__)
require File.expand_path('../models/reviewer', __FILE__)
require File.expand_path('../models/user', __FILE__)

class Desiccator < Sinatra::Base
  require 'sinatra/reloader' if development?

  register Sinatra::ActiveRecordExtension
  set :database, {adapter: 'sqlite3', database: File.expand_path('../db/db.sqlite3', __FILE__)}
  set :views, File.expand_path('../views', __FILE__)
  set :method_override, true

end

require File.expand_path('../app/routes', __FILE__)
require File.expand_path('../app/helpers', __FILE__)
