class LikesController < ApplicationController
  def create
    @post = current_user.posts.find(params[:post_id])
    @like = Like.new(user: current_user, post: @post)

    if @like.save
      redirect_to user_post_path(current_user, @post)
    end
  end
end