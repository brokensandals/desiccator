class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :repo
      t.string :state
      t.integer :pull_number
      t.text :title
      t.datetime :due_at
    end
  end
end
