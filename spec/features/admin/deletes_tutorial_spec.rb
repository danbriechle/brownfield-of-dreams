require 'rails_helper'

feature "An admin visiting the admin dashboard" do
  scenario "deletes a tutorial" do
    admin = create(:admin)
    tutorial_1 = create(:tutorial)
    tutorial_2 = create(:tutorial)

    video = create(:video, tutorial_id: tutorial_1.id)
    video_2 = create(:video, tutorial_id: tutorial_1.id)
    video_3 = create(:video, tutorial_id: tutorial_1.id)

    video_4 = create(:video, tutorial_id: tutorial_2.id)


    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit "/admin/dashboard"

    within ".tutorial-#{tutorial_1.id}" do
      click_on "Destroy"
    end

    expect(current_path).to eq(admin_dashboard_path)

    expect(page).to_not have_content(tutorial_1.title)
    expect(page).to have_content(tutorial_2.title)

  end
end
