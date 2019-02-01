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

end
