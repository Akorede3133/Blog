class PostsController < ApplicationController
  def index
    @posts = User.find(params[:user_id]).posts.includes(:comments)
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = 'Post created successfully!'
      redirect_to user_post_path(current_user, @post)
    else
      flash.now[:error] = 'Post was not created!'
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to user_posts_path(current_user)
  end



  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
