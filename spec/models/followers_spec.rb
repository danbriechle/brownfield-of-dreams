require 'rails_helper'

RSpec.describe "Follower" do

  it 'exists' do
    response = {"login" => "Dave", "html_url" => "Place"}
    repo = Follower.new(response)

    expect(repo).to be_truthy
    expect(repo.class).to eq(Follower)
  end

  it 'has attributes' do
    response = {"login" => "Dave", "html_url" => "Place"}
    repo = Follower.new(response)

    expect(repo.name).to eq("Dave")
    expect(repo.url).to eq("Place")
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

end
