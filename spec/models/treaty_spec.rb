require 'rails_helper'

RSpec.describe Treaty, type: :model do
  describe 'validations' do
    let(:treaty) { create(:treaty) }
    it 'name should be present' do
      treaty.name = nil
      expect(treaty).to_not be_valid
    end

    it 'email should be present' do
      treaty.amount = nil
      expect(treaty).to_not be_valid
    end

    it 'owner should be present' do
      treaty.user = nil
      expect(treaty).to_not be_valid
    end
  end
end
