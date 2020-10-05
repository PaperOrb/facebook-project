class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  def create
    @comment = current_user.comments.new(comment_params)
    @user = @comment.post.user

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @user, notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @comment }
      else
        flash.now[:alert] = "Error creating post"
        format.html { redirect_to @user, notice: 'Comment was successfully created.' }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user = @comment.post.user
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to @user, notice: 'Comment was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:body, :user_id, :post_id)
    end
end
