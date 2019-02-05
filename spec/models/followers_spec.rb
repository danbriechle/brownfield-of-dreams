require 'rails_helper'

RSpec.describe "Follower" do

  it 'exists' do
    response = {"login" => "Dave", "html_url" => "Place"}
    follower = Follower.new(response)

    expect(follower).to be_truthy
    expect(follower.class).to eq(Follower)
  end

  it 'has attributes' do
    response = {"login" => "Dave", "html_url" => "Place"}
    follower = Follower.new(response)

    expect(follower.name).to eq("Dave")
    expect(follower.url).to eq("Place")
  end

  it 'can take users git hub api token' do
    VCR.use_cassette("dans_followers") do
      user = create(:user, token: ENV["DAN_GIT_API_KEY"])
      conn = Faraday.new(url: "https://api.github.com") do |f|
        f.headers["Authorization"] = "Token #{user.token}"
        f.adapter Faraday.default_adapter
      end

      response = conn.get "/user/followers"

      mary = JSON.parse(response.body).first

      mary_follower = Follower.new(mary)

      expect(mary_follower.url).to eq(mary["html_url"])
      expect(mary_follower.name).to eq(mary["login"])
    end
  end

  describe "instance methods" do
    it '.is_user?' do 
      gh_resp1 = {"html_url" => "https://www.google.com", "login" => "lmao", "id" => 123}
      gh_resp2 = {"html_url" => "https://www.google.com", "login" => "lol", "id" => 321}
      follower = Follower.new(gh_resp1)
      follower2 = Follower.new(gh_resp2)

      user = create(:user, uid: 123)

      expect(follower.is_user?).to be_truthy
      expect(follower2.is_user?).to_not be_truthy
    end
  end
  

end
