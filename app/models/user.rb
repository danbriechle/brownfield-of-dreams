class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password
  validates_presence_of :first_name
  enum role: [:default, :admin]
  has_secure_password

  def repo_factory
    raw_repos = GithubService.repos(self)
    Repo.generate(raw_repos)
  end 

  def follower_factory
    raw_following = GithubService.user_relation(self, "followers")
    UserRelation.generate(raw_following)
  end
  
  def following_factory
    raw_following = GithubService.user_relation(self, "following")
    UserRelation.generate(raw_following)
  end 
end
