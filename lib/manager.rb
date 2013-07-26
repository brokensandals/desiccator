class Manager
  def initialize(base_url)
    Octokit.configure do |c|
      c.api_endpoint = base_url
    end
    @octokit = Octokit::Client.new
  end

  def crawl(owner)
    puts "Crawling #{owner}"
    @octokit.repositories(owner).each do |repo_details|
      repo = "#{owner}/#{repo_details.name}"
      puts "Crawling #{repo}"
      pulls = (@octokit.pull_requests(repo) + @octokit.pull_requests(repo, 'closed'))
      pulls.each do |pull|
        puts "Crawling #{repo} pull #{pull.number}"
        sync_review(repo, pull)
      end
    end
  end

  def sync_review(repo, pull)
    review = Review.where(repo: repo, pull_number: pull.number).first_or_create
    review.state = pull.state
    review.title = pull.title
    review.due_at = get_due_at(pull)
    review.save!

    comments = @octokit.issue_comments(repo, pull.number)
    sync_reviewers(review, pull, comments)
  end

  def sync_reviewers(review, pull, comments)
    pull.body =~ /^Reviewers: (.+)$/
    return unless $1
    $1.split(/[\s,]+/).map do |id|
      login = id.sub('@', '').downcase
      next unless user = sync_user(login) # TODO don't call this as often
      completion = comments.detect {|c| c.body == '+1' && c.user.login.downcase == login}
      reviewer = review.reviewers.where(user_id: user.id).first_or_create
      reviewer.completed_at = (completion.created_at if completion)
      reviewer.save!
    end

    # TODO delete old reviewers?
  end

  def sync_user(login)
    github_user = @octokit.user(login)
    return nil unless github_user
    user = User.where(login: login).first_or_create
    user.name = github_user.name
    user.image_url = github_user.avatar_url
    user.save!
    user
  end

  def get_due_at(pull)
    pull.body =~ /^Due: (.+)\s*$/
    $1
  end
end