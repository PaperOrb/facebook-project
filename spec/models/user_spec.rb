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

  context 'friend request is sent' do
    it '#friend_requests show received requests' do
      u1 = create(:user)
      u2 = create(:user)
      u1.friendships.create(user_id: u1.id, friend_id: u2.id)
      expect(u2.received_friend_requests.first.id).to eq(u1.id)
    end

    it '#pending_requests show sent requests' do
      u1 = create(:user)
      u2 = create(:user)
      u1.friendships.create(user_id: u1.id, friend_id: u2.id)
      expect(u1.sent_friend_requests.first.id).to eq(u2.id)
    end

    it '#friends shows mutual confirmed friends' do
      u1 = create(:user)
      u2 = create(:user)
      friendship_params = { user_id: u1.id, friend_id: u2.id, confirmed: true }
      @friendship = Friendship.create(friendship_params)

      expect(u1.friends).to include(u2)
      expect(u2.friends).to include(u1)
    end

    it '#friends shows no friends when not confirmed' do
      u1 = create(:user)
      u2 = create(:user)
      friendship_params = { user_id: u1.id, friend_id: u2.id }
      @friendship = Friendship.create(friendship_params)

      expect(u1.friends).not_to include(u2)
      expect(u2.friends).not_to include(u1)
    end
  end

  it '#find_friendship returns friendship for regardless of who sender was' do
    u1 = create(:user)
    u2 = create(:user)
    friendship_params = {user_id: u1.id, friend_id: u2.id }
    @friendship = Friendship.create(friendship_params)
    expect(u1.find_friendship(u2)).to eq(@friendship)
    expect(u2.find_friendship(u1)).to eq(@friendship)
  end
end