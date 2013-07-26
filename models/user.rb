class User < ActiveRecord::Base
  has_many :reviewers
  has_many :reviews, through: :reviewers
  has_many :repos
end