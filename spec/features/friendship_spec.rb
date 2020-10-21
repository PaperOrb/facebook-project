require 'rails_helper'

RSpec.describe 'Friend requests', type: :feature do
  before(:each) do
    @u1 = create(:user)
    @u2 = create(:user)
  end

  it 'can be sent by logged in user' do
    login_as(@u1)
    visit users_path

    click_link("add_friend_#{@u2.id}")
    expect(page).to have_text("Friend request sent.")
  end

  it 'can not be sent by logged out user' do
    visit users_path

    expect(page).to_not have_text("Add friend")
  end
end

RSpec.describe 'Received friend requests', type: :feature do
  before(:each) do
    @u1 = create(:user)
    @u2 = create(:user)
    @u1.friendships.create(friend_id: @u2.id)
    login_as(@u2)
    visit users_path
  end

  it 'can be declined' do
    expect(page).to have_text("Accept friend request?")
    click_link("No")

    expect(page).to_not have_text("Accept friend request?")
  end

  it 'can be accepted' do
    expect(page).to have_text("Accept friend request?")
    click_link("Yes /")

    expect(page).to_not have_text("Accept friend request?")
  end
end