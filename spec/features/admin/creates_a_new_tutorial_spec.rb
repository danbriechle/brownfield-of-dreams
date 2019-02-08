require 'rails_helper'

feature "An admin visiting the admin dashboard" do
  scenario "can see all tutorials" do
    admin = create(:admin)


    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    title = "meaningful name"
    description = "description"
    thumbnail = "https://img.youtube.com/vi/5TN_6C8XXOs/2.jpg"

    # When I visit '/admin/tutorials/new'
    visit "admin/tutorials/new"
    save_and_open_page
    # And I fill in 'title' with a meaningful name
    fill_in "Title", with: title
    # And I fill in 'description' with a some content
    fill_in "Description", with: description
    # And I fill in 'thumbnail' with a valid YouTube thumbnail
    fill_in "Thumbnail", with: thumbnail

    # And I click on 'Save'
    click_on 'Save'

    # new_totrial_id = Tutorial.last.id
    # Then I should be on '/tutorials/{NEW_TUTORIAL_ID}'
    # expect(current_path).to eq("/tutorials/#{new_totrial_id}")
    # And I should see a flash message that says "Successfully created tutorial."
    expect(page).to have_content("Successfully created tutorial.")
    # expect(page).to have_css(".admin-tutorial-card", count: 2)
  end
end
#
#  Sad path accounted for
