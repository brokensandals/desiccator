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
require './lib/manager'
require './app/desiccator'
require './app/helpers'

require './models/review'
require './models/reviewer'
require './models/user'
