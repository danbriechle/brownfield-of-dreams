require 'rails_helper'

describe "User Relations" do
  context "can be set to find following" do
    it "can find following" do
      VCR.use_cassette("parse & generate following relation") do 
        user = create(:user, token: ENV["NICO_GIT_API_KEY"])
        raw_following = GithubService.user_relation(user, "following")
        parsed_following = JSON.parse(raw_following.body)

        following = UserRelation.generate(raw_following)
        expect(following[0].class).to eq(UserRelation)
        expect(following[0].url).to eq(parsed_following.first["html_url"])
        expect(following[0].username).to eq(parsed_following.first["login"])
      end
    end
    it "can find followers" do
      VCR.use_cassette("parse & generate follower relation") do 
        user = create(:user, token: ENV["NICO_GIT_API_KEY"])
        raw_following = GithubService.user_relation(user, "followers")
        parsed_following = JSON.parse(raw_following.body)

        following = UserRelation.generate(raw_following)
        expect(following[0].class).to eq(UserRelation)
        expect(following[0].url).to eq(parsed_following.first["html_url"])
        expect(following[0].username).to eq(parsed_following.first["login"])
      end
    end
  end
end
