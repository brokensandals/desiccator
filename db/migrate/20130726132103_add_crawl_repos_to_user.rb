class AddCrawlReposToUser < ActiveRecord::Migration
  def change
    add_column :users, :crawl_repos, :boolean, null: false, default: false
    add_index :users, :crawl_repos
  end
end
