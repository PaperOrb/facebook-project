class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: %i[facebook]

  validates :name, presence: true, uniqueness: true

  has_many :friendships # finds records with you as the user_id to see pending_friends you've sent
  has_many :inverse_friendships, class_name: "Friendship", foreign_key: "friend_id" # finds records with you as the friend_id to see friend_requests to you
  # this is how you create a friendship: u1.friendships.create(user_id: u1.id, friend_id: u2.id)

  has_many :posts
  has_many :comments

  def friends
    friends_array = friendships.map { |friendship| friendship.friend if friendship.confirmed }
    friends_array += inverse_friendships.map { |friendship| friendship.user if friendship.confirmed }
    friends_array.compact
  end

  def received_friend_requests
    inverse_friendships.map { |friendship| friendship.user unless friendship.confirmed }.compact
  end

  def sent_friend_requests
    friendships.map { |friendship| friendship.friend unless friendship.confirmed }.compact
  end
end
