require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:email)}
    it {should validate_presence_of(:first_name)}
    it {should validate_presence_of(:password)}
  end

  describe 'roles' do
    it 'can be created as default user' do
      user = User.create(email: 'user@email.com', password: 'password', first_name:'Jim', role: 0)

      expect(user.role).to eq('default')
      expect(user.default?).to be_truthy
    end

    it 'can be created as an Admin user' do
      admin = User.create(email: 'admin@email.com', password: 'admin', first_name:'Bob', role: 1)

      expect(admin.role).to eq('admin')
      expect(admin.admin?).to be_truthy
    end
  end

  describe "api parsing" do 
    it 'can parse and generate repo data/objects' do 
      VCR.use_cassette "generate and parse user repos" do
        user = create(:user, token: ENV["NICO_GIT_API_KEY"])
        # raw_repos = GithubService.repos(user)

        expected = user.repo_factory
        expect(expected[0].class).to eq(Repo)
      end
    end 
    it 'can parse and generate repo data/objects' do 
      VCR.use_cassette("parse & generate all followers relation in user") do 
        user = create(:user, token: ENV["NICO_GIT_API_KEY"])
        followings = user.follower_factory
        raw_following = GithubService.user_relation(user, "followers")
        parsed_following = JSON.parse(raw_following.body)

        expect(followings[0].class).to eq(UserRelation)
        expect(followings[0].url).to eq(parsed_following.first["html_url"])
        expect(followings[0].username).to eq(parsed_following.first["login"])
      end
    end
    it 'can parse and generate repo data/objects' do 
      VCR.use_cassette("parse & generate all following relation in user") do 
        user = create(:user, token: ENV["NICO_GIT_API_KEY"])
        followings = user.following_factory
        raw_following = GithubService.user_relation(user, "following")
        parsed_following = JSON.parse(raw_following.body)

        expect(followings[0].class).to eq(UserRelation)
        expect(followings[0].url).to eq(parsed_following.first["html_url"])
        expect(followings[0].username).to eq(parsed_following.first["login"])
      end
    end
  end
end
