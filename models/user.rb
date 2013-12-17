class User < ActiveRecord::Base
  has_many :reviewer_statuses
  has_many :owned_reviews, class_name: 'Review'
  has_many :reviewer_reviews, through: :reviewer_statuses, source: :review
  has_many :repos
  has_many :repo_owner_watches, dependent: :destroy

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

  # Open reviews this user is watching but not a reviewer of.
  def open_watched_reviews
    repo_owner_watches.map(&:watched_user).map(&:repos).flatten.map {|repo| repo.reviews.where(state: 'open')}.flatten -
      owned_reviews -
      reviewer_reviews
  end

  def repo_owner_watches_string
    repo_owner_watches.map(&:watched_user).map(&:login).join(' ')
  end

  def repo_owner_watches_string=(str)
    logins = str.downcase.split
    to_add = logins.dup
    repo_owner_watches.to_a.dup.each do |row|
      if logins.include? row.watched_user.login_key
        to_add.delete row.watched_user.login_key
      else
        repo_owner_watches.destroy(row)
      end
    end

    to_add.each do |login|
      repo_owner_watches.create(watched_user_id: User.find_by_login_key(login).id)
    end
  end
end