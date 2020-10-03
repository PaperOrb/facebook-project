require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validations' do
    it 'ensures name is present' do
      user = build(:user, name: nil).save
      expect(user).to eq(false)
    end

    it 'ensures email is present' do
      user = build(:user, email: nil).save
      expect(user).to eq(false)
    end

    it 'ensures password is present' do
      user = build(:user, password: nil).save
      expect(user).to eq(false)
    end

    it 'ensures saves successfully' do
      user = build(:user).save
      expect(user).to eq(true)
    end

    it 'ensures name is unique' do
      u1 = create(:user, name: '1')
      u2 = build(:user, name: '1')
      expect(u2.valid?).to eq(false)
    end

    it 'ensures email is unique' do
      u1 = create(:user, email: '1@1.com')
      u2 = build(:user, email: '1@1.com')
      expect(u2.valid?).to eq(false)
    end

    it 'ensures password is 6 characters long' do
      u1 = build(:user, password: 'asdf')
      expect(u1.valid?).to eq(false)
    end
  end
end
