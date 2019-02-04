require 'rails_helper'

RSpec.describe Video, type: :model do
  describe 'validations' do
    it { should validate_presence_of :position}
  end

  describe 'class methods' do
    it '.increment_position' do
      create(:video, position: 0)
      create(:video, position: 1)
      create(:video, position: 2)

      Video.increment_position

      expect(Video.first.position).to eq(1)
    end
  end
end
