class Review < ActiveRecord::Base
  belongs_to :repo
  has_many :reviewer_statuses
end