class Review < ActiveRecord::Base
  has_many :reviewers
end