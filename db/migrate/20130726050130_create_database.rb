class CreateDatabase < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.text :name
      t.string :login
      t.index :login, unique: true
      t.string :image_url
    end

    create_table :repos do |t|
      t.integer :user_id
      t.string :name
      t.index [:user_id, :name], unique: true
      t.text :default_reviewers
      t.string :default_review_duration
    end

    create_table :reviews do |t|
      t.integer :repo_id
      t.string :state
      t.integer :pull_number
      t.index [:repo_id, :pull_number], unique: true
      t.text :title
      t.datetime :due_at
    end

    create_table :reviewers do |t|
      t.integer :review_id
      t.integer :user_id
      t.index [:review_id, :user_id], unique: true
      t.datetime :completed_at
    end
  end
end
