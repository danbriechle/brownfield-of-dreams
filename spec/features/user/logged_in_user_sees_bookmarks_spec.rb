require 'rails_helper'

describe 'A registered user' do
  context 'when I visit /dashboard' do
    it 'sees a list of all bookmarks' do
      tutorial_1 = create(:tutorial, title: "turtorial 1")
      video_1 = create(:video, title: "video 1", tutorial: tutorial_1)
      tutorial_2 = create(:tutorial, title: "tutorial 2")
      video_2 = create(:video, title: "video 2", tutorial: tutorial_2)

      user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit tutorial_path(tutorial_1)

      expect {
        click_on 'Bookmark'
      }.to change { UserVideo.count }.by(1)

      expect(page).to have_content("Bookmark added to your dashboard")

      visit tutorial_path(tutorial_2)
      click_on 'Bookmark'

      visit '/dashboard'
      
      expect(page).to have_content("Bookmarked Segments")

      within ".bookmarks" do
        expect(page).to have_content("Title: video 1")
        expect(page).to have_content("Title: video 2")
        expect(page).to have_content("Position: 0")
      end

      # Then I should see a list of all bookmarked segments under the Bookmarked Segments section
      # And they should be organized by which tutorial they are a part of
      # And the videos should be ordered by their position
    end
  end
end
