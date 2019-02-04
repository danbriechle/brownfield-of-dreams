require 'rails_helper'
describe "Dasboard page shows tutorials" do
    it "user sees all tutorials" do
        tut1 = create(:tutorial, classroom: true)
        tut2 = create(:tutorial)

        user = create(:user)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
        
        visit root_path

        expect(page).to have_content(tut1.title) 
        expect(page).to have_content(tut2.title) 
    end
    it "visitor sees non-classroom tutorials" do
        tut1 = create(:tutorial, classroom: true)
        tut2 = create(:tutorial)
        
        visit root_path

        expect(page).to_not have_content(tut1.title) 
        expect(page).to have_content(tut2.title) 
    end
end
