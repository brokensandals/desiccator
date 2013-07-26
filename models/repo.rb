class Repo < ActiveRecord::Base
  belongs_to :user
  has_many :reviews

  def path
    "#{user.login}/#{name}"
  end

  def default_due_at(started_at)
    return nil unless default_review_duration
    DateUtil.parse(started_at, default_review_duration)
  rescue => ex
    puts ex
    nil
  end
end