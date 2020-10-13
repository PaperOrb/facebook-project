class FriendshipsController < ApplicationController
  # used this guide for learning about setting up friendships: https://smartfunnycool.com/friendships-in-activerecord/
  before_action :set_friendship, only: [:confirm_friend, :destroy]

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

  def destroy
    @friendship.destroy
    respond_to do |format|
      format.html { redirect_to users_path, notice: 'Friendship declined!' }
      format.json { head :no_content }
    end
  end

  private

  def set_friendship
    @friendship = Friendship.find_by(user_id: friendship_params[:user_id], friend_id: friendship_params[:friend_id])
  end

  # Only allow a list of trusted parameters through.
  def friendship_params
    params.require(:friendship).permit(:user_id, :friend_id)
  end
end