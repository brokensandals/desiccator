class Repo < ActiveRecord::Base
  belongs_to :user
  has_many :reviews

  def path
    "#{user.login}/#{name}"
  end
end