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
    end

    context 'friend request is confirmed' do
      it '#friends shows confirmed friends' do
        u1 = create(:user)
        u2 = create(:user)
        @friendship = u1.friendships.create(user_id: u1.id, friend_id: u2.id)
        @friendship.confirm_friend
        expect(u1.friends.first.id).to eq(u2.id)
        expect(u2.friends.first.id).to eq(u1.id)
      end
    end

    context 'u2 declines friend request from u1' do
      it 'u1 and u2 arent friends' do
      end
    end
  end
end