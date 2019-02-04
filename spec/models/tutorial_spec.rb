require 'rails_helper'

RSpec.describe Tutorial, type: :model do
    it '.visitor_tuts - only non classroom tutorials' do 
        tut1 = create(:tutorial, classroom: true)
        tut2 = create(:tutorial)
        tut3 = create(:tutorial)

        expect(Tutorial.visitor_tuts.length).to eq(2)
        expect(Tutorial.visitor_tuts.first.title).to eq(tut2.title)
    end
end
