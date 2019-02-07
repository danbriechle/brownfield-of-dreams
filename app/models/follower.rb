class Follower
 attr_reader :url, :name, :uid
  def initialize(gh_response)
    @url = gh_response["html_url"]
    @name = gh_response["login"]
    @uid = gh_response["id"]
  end

  def self.generate(gh_response)
    JSON.parse(gh_response.body).map do |object|
      Follower.new(object)
    end
  end

  def is_user?
    User.where(uid: self.uid).first ? true : false
  end
end
