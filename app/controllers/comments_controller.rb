class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  def create
    @comment = current_user.comments.new(comment_params) # need to pass post to this comment, then give comment.post.user.id to the redirect below 
    @user_id = @comment.post.user.id
    require 'pry'; binding.pry

    respond_to do |format|
      if @comment.save
        format.html { redirect_to :controller => 'users', :action => 'index', notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @comment }
      else
        flash.now[:alert] = "Error creating post"
        format.html { redirect_to controller: 'users', action: 'show', id: @user_id, notice: 'Comment was successfully created.' }
        
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to comments_url, notice: 'Comment was successfully destroyed.' }
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
