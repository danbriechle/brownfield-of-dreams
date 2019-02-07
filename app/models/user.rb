class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos

  has_many :friendships
  has_many :friends, through: :friendships

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password, if: :password
  validates_presence_of :first_name
  enum role: [:default, :admin]
  has_secure_password

  def tutorials
    Tutorial.joins(videos: :users)
            .where('users.id = ?', self.id)
            .group(:id)
  end

  def is_friend?(potential_friend_id)
    Friendship.where(user_id: self.id, friend_id: potential_friend_id).exists?
  end
end
