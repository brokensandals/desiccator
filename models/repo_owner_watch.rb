class RepoOwnerWatch < ActiveRecord::Base
  belongs_to :user
  belongs_to :watched_user, class_name: 'User'
end