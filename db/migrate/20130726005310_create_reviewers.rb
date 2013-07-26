class CreateReviewers < ActiveRecord::Migration
  def change
    create_table :reviewers do |t|
      t.integer :review_id
      t.integer :user_id
      t.datetime :completed_at
    end
  end
end
