class LikesController < ApplicationController
  before_action :set_liked_content

  def create
    @like = @liked_content.likes.build(like_params)

    respond_to do |format|
      if @like.save
        format.html { redirect_to user_path(@liked_content.user_id), notice: "Liked!" }
      else
        format.html { redirect_to user_path(@liked_content.user_id), notice: "Failed to like!"}
      end
    end
  end

  def destroy
    @like = @liked_content.likes.find_by(user_id: current_user.id)

    respond_to do |format|
      if @like.destroy
        format.html { redirect_to user_path(@liked_content.user_id), notice: "Removed like"}
      else
        format.html { redirect_to user_path(@liked_content.user_id), notice: "Couldn't remove like"}
      end
    end
  end

  private

  def set_liked_content
    if like_params[:likeable_type] == "Post"
      @liked_content = Post.find(like_params[:likeable_id])
    else
      @liked_content = Comment.find(like_params[:likeable_id])
    end
  end

  def like_params
    params.require(:like).permit(:user_id, :likeable_id, :likeable_type)
  end
end
