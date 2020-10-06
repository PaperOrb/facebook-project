class FriendshipsController < ApplicationController
  # used this guide for learning about setting up friendships: https://smartfunnycool.com/friendships-in-activerecord/
  before_action :set_friendship, only: [:show, :edit, :update, :destroy]

  def index
    @friendships = Friendship.all
  end

  # GET /friendships/new
  def new
    @friendship = Friendship.new
  end

  def create
    user = User.find_by(id: friendship_params[:user_id])
    friend = User.find_by(id: friendship_params[:friend_id])
    @friendship = Friendship.new(friendship_params)

    respond_to do |format|
      require 'pry'; binding.pry
      if user.friends.include?(friend)
        #format.html { redirect_to friendships_path, notice: "#{friend.name} is already a friend!"  }
        format.json { render json: @friendship.errors, status: :unprocessable_entity }
      else
        format.html { redirect_to friendships_path, notice: 'Friend request sent!' }
        format.json { render :show, status: :created, location: @friendship }
      end
    end
  end

  def destroy
    @friendship.destroy
    respond_to do |format|
      format.html { redirect_to friendships_url, notice: 'Friendship was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_friendship
    @friendship = Friendship.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def friendship_params
    params.require(:friendship).permit(:user_id, :friend_id)
  end
end