require 'rails_helper'

describe "Github Service" do
  context "can generate the following responses" do
    it "/users/repos - can return all the repos for a given user" do
      VCR.use_cassette("gh service repo call") do
        user = create(:user, token: ENV["NICO_GIT_API_KEY"])
        user_repos_json = GithubService.repos(user)
        parsed_response = Repo.generate(user_repos_json)

        expect(JSON.parse(user_repos_json.body)[0].keys).to include("assignees_url", "forks_count")
        expect(parsed_response.first.class).to eq(Repo)
       end
    end
  end
end
