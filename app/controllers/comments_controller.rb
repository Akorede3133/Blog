class CommentsController < ApplicationController
  def create
    @post = current_user.posts.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    return unless @comment.save

    redirect_to user_post_path(current_user, @post)
  end

  def destroy
    @post = current_user.posts.find(params[:post_id])
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to user_post_path(current_user, @post)
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
