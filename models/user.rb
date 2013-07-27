class User < ActiveRecord::Base
  has_many :reviewer_statuses
  has_many :reviews, through: :reviewer_statuses
  has_many :repos
end