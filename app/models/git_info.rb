class GitInfo

  def self.repos(current_user)
    Repo.generate(GitService.conn(current_user.token, "repos")).take(5)
  end

  def self.followers(current_user)
    Follower.generate(GitService.conn(current_user.token, "followers")).take(5)
  end

  def self.following(current_user)
    Following.generate(GitService.conn(current_user.token, "following")).take(5)
  end

end
