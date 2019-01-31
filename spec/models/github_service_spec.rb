require 'rails_helper'

describe "Github Service" do
  context "can generate the following responses" do
    it "/users/repos - can return all the repos for a given user" do
      VCR.use_cassette("gh service repo call1") do
        user = create(:user, token: ENV["NICO_GIT_API_KEY"])
        user_repos_json = GithubService.repos(user)
        parsed_response = Repo.generate(user_repos_json)

        response_keys = JSON.parse(user_repos_json.body)[0].keys
        expect(response_keys).to include("assignees_url", "forks_count")
        expect(parsed_response.first.class).to eq(Repo)
       end
    end

    it "/user/followers - shows all the followers for a user" do 
      VCR.use_cassette("gh user followers1") do 
        user = create(:user, token: ENV["NICO_GIT_API_KEY"])
        user_followers_json = GithubService.user_relation(user, "followers")
        user_followings_json = GithubService.user_relation(user, "following")

        expect(user_followings_json.body).to be_truthy 
        expect(user_followers_json.body).to be_truthy 
      end
    end
  end
end
