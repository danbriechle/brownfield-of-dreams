class Tutorial < ApplicationRecord
  has_many :videos, ->  { order(position: :ASC) }, :dependent => :delete_all
  acts_as_taggable_on :tags, :tag_list
  accepts_nested_attributes_for :videos
  validates_presence_of :title, :description, :thumbnail

  def self.visitor_tuts
    Tutorial.where(classroom: false)
  end
end
