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

  describe 'instance methods' do
    it '.tutorials' do
      tutorial_1 = create(:tutorial, title: "turtorial 1")
      video_1 = create(:video, title: "video 1", tutorial: tutorial_1)
      tutorial_2 = create(:tutorial, title: "tutorial 2")
      video_2 = create(:video, title: "video 2", tutorial: tutorial_2)

      user = create(:user)
      bookmark_1 = create(:user_video, user_id: user.id, video_id: video_1.id)
      bookmark_2 = create(:user_video, user_id: user.id, video_id: video_2.id)

      expect(user.tutorials.first.title).to eq("turtorial 1")
      expect(user.tutorials.last.title).to eq("turtorial 2")
    end
  end
end
