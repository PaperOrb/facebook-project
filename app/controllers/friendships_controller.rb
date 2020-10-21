class FriendshipsController < ApplicationController
  # used this guide for learning about setting up friendships: https://smartfunnycool.com/friendships-in-activerecord/
  before_action :set_friendship, only: [:confirm_friend, :remove_friend]

  def index
    @friendships = Friendship.all
  end

  def create
    @friendship = Friendship.new(friendship_params)

    respond_to do |format|
      if @friendship.save
        format.html { redirect_to users_path, notice: "Friend request sent to #{@friendship.friend.name}!"  }
        format.json { render json: @friendship.errors, status: :unprocessable_entity }
      else
        format.html { redirect_to users_path, notice: 'Failed friend request!' }
        format.json { render :show, status: :created, location: @friendship }
      end
    end
  end

  def confirm_friend
    @friendship.confirmed = true
    respond_to do |format|
      if @friendship.save
        format.html { redirect_to users_path, notice: "You are now friends!"  }
      else
        format.html { redirect_to users_path, notice: 'Failed to accept friend request!' }
      end
    end
  end

  def remove_friend
    respond_to do |format|
      if @friendship.destroy
        format.html { redirect_to users_path, notice: "Remove friend!"  }
      else
        format.html { redirect_to users_path, notice: 'Failed to remove friend!' }
      end
    end
  end

  private

  def set_friendship
    @friendship = current_user.find_friendship(User.find(params[:id]))
  end

  # Only allow a list of trusted parameters through.
  def friendship_params
    params.require(:friendship).permit(:user_id, :friend_id)
  end
end