class Review < ActiveRecord::Base
  belongs_to :repo
  has_many :reviewers
end