require 'rails_helper'

describe "As a user" do
  context "when I visit my dashboard" do
    it "there is link to add GH followers as friend on the site if they've connected to GH" do
        VCR.use_cassette("test relationships") do
            dan = create(:user, uid: 123123, first_name: "dan", token: ENV["DAN_GIT_API_KEY"])
            ian = User.create!(email: 'user1@user.com', first_name: "Namey", last_name: "McNameface", password: "password", role: :default, uid:"168030")
            mary = User.create!(email: 'user2@user.com', first_name: "Namey_1", last_name: "McNameface", password: "password", role: :default, uid:"40919519")

            # nico = create(:user, uid: 43397150, first_name: "nico", token: ENV["NICO_GIT_API_KEY"])
            anna = 6686861

            allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(dan)

            visit dashboard_path

            within("#following-#{ian.uid}") do
                expect(page).to have_button("Add as Friend")
            end

            within("#followers-#{mary.uid}") do
                expect(page).to have_button("Add as Friend")
            end

            within("#following-#{anna}") do
                expect(page).to_not have_button("Add as Friend")
            end

            within("#following-#{ian.uid}") do
                click_on "Add as Friend"
            end

            expect(page).to have_content("Friend Added!")

        end
    end
  end
end
