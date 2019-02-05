class Video < ApplicationRecord
  has_many :user_videos
  has_many :users, through: :user_videos
  belongs_to :tutorial
  validates_presence_of :position, :allow_nil => false


 def self.increment_position
   Video.where('position = ?', '0').update_all(position: '1')
 end

end
