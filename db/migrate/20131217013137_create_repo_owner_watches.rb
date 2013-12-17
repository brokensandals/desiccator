class CreateRepoOwnerWatches < ActiveRecord::Migration
  def change
    create_table :repo_owner_watches do |t|
      t.integer :user_id
      t.integer :watched_user_id
    end
  end
end
