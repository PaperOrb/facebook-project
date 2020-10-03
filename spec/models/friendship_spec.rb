require 'rails_helper'

RSpec.describe User, type: :model do
  context 'friend request is sent' do
    it '#friend_requests show received requests' do
      u1 = create(:user)
      u2 = create(:user)
      u1.friendships.create(user_id: u1.id, friend_id: u2.id)
      expect(u2.friend_requests.first.id).to eq(u1.id)
    end

    it '#pending_requests show sent requests' do
      u1 = create(:user)
      u2 = create(:user)
      u1.friendships.create(user_id: u1.id, friend_id: u2.id)
      expect(u1.pending_friends.first.id).to eq(u2.id)
    end
  end

  context 'friend request is confirmed' do
    it '#friends shows confirmed friends' do
      u1 = create(:user)
      u2 = create(:user)
      u1.friendships.create(user_id: u1.id, friend_id: u2.id)
      u2.confirm_friend(u1)
      expect(u1.friends.first.id).to eq(u2.id)
      expect(u2.friends.first.id).to eq(u1.id)
    end
  end

  context 'u2 declines friend request from u1' do
    it 'u1 and u2 arent friends' do
    end
  end
end