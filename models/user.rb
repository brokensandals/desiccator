class User < ActiveRecord::Base
  has_many :reviewer_statuses
  has_many :owned_reviews, class_name: 'Review'
  has_many :reviewer_reviews, through: :reviewer_statuses, source: :review
  has_many :repos

  # Reviews this user is a reviewer of, which have not yet been closed.
  def open_reviewer_reviews
    reviewer_reviews.where(state: 'open')
  end

  # Open reviews which this user needs to review.
  def incomplete_reviews
    open_reviewer_reviews - complete_reviews
  end

  # Open reviews this user has finished reviewing.
  def complete_reviews
    open_reviewer_reviews.select do |review|
      review.reviewer_statuses.select(&:completed_at).map(&:user).include?(self)
    end
  end
end