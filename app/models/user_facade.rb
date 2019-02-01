
class UserFacade
  attr_reader :repos, :followers, :following
  def initialize(current_user)
    @repos = GitInfo.repos(current_user)
    @followers = GitInfo.followers(current_user)
    @following = GitInfo.following(current_user)
  end
end
