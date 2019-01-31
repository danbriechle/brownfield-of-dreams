class Follower
 attr_reader :url, :name
  def initialize(gh_response)
    @url = gh_response["html_url"]
    @name = gh_response["login"]
  end

  def self.generate(gh_response)
    JSON.parse(gh_response.body).map do |object|
      Follower.new(object)
    end
  end
end
