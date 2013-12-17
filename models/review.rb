class Review < ActiveRecord::Base
  belongs_to :repo
  belongs_to :user
  has_many :reviewer_statuses

  def overdue?
    due_at && !due_at.future?
  end
end