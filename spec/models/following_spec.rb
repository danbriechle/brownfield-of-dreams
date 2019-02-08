require 'rails_helper'

RSpec.describe "Following" do

  it 'exists' do
    response = {"login" => "Dave", "html_url" => "Place"}
    following = Following.new(response)

    expect(following).to be_truthy
    expect(following.class).to eq(Following)
  end

  it 'has attributes' do
    response = {"login" => "Dave", "html_url" => "Place"}
    following = Following.new(response)

    expect(following.name).to eq("Dave")
    expect(following.url).to eq("Place")
  end

  it 'can take users git hub api token' do
    VCR.use_cassette("dans_following") do
      user = create(:user, token: ENV["DAN_GIT_API_KEY"])
      conn = Faraday.new(url: "https://api.github.com") do |f|
        f.headers["Authorization"] = "Token #{user.token}"
        f.adapter Faraday.default_adapter
      end

      response = conn.get "/user/following"

      ian = JSON.parse(response.body).first

      ian_follower = Following.new(ian)

      expect(ian_follower.url).to eq(ian["html_url"])
      expect(ian_follower.name).to eq(ian["login"])
    end
  end

  it 'can generate followees from api response' do
    VCR.use_cassette("following") do
      user = create(:user, token: ENV["DAN_GIT_API_KEY"])
      conn = Faraday.new(url: "https://api.github.com") do |f|
        f.headers["Authorization"] = "Token #{user.token}"
        f.adapter Faraday.default_adapter
      end

      response = conn.get "/user/following"

      actual = JSON.parse(response.body).first["id"]

      follower = Following.generate(response)

      expected = follower.first.uid

      expect(expected).to eq(actual)
    end
  end

  describe "instance methods" do
    it '.is_user?' do
      gh_resp1 = {"html_url" => "https://www.google.com", "login" => "lmao", "id" => 123}
      gh_resp2 = {"html_url" => "https://www.google.com", "login" => "lol", "id" => 321}
      follower = Following.new(gh_resp1)
      follower2 = Following.new(gh_resp2)

      user = create(:user, uid: 123)

      expect(follower.is_user?).to be_truthy
      expect(follower2.is_user?).to_not be_truthy
    end
  end


end
