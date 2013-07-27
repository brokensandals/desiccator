class User < ActiveRecord::Base
  has_many :reviewer_statuses
  has_many :owned_reviews, class_name: 'Review'
  has_many :reviewer_reviews, through: :reviewer_statuses, source: :review
  has_many :repos
end