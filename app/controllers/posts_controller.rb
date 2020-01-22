class PostsController < ApplicationController
  def index
    @post = Post.new
    @timeline_posts = current_user.posts
  end

  def show
    @post = Post.find_by(id: params[:id])
  end

  def create
    @post = current_user.posts.create post_params

    respond_to do |format|
      format.js
    end
  end

  def comment
    @post = Post.find_by(id: params[:id])
    @post.comments.create content: params[:content], user: current_user
    redirect_to @post
  end

  def like
    @post = Post.find params[:id]
    @post.likes.create user: current_user

    respond_to do |format|
      format.js { render :refresh_post_likes }
    end
  end

  def dislike
    @post = Post.find params[:id]
    @post.likes.find_by(user: current_user)&.destroy

    respond_to do |format|
      format.js { render :refresh_post_likes }
    end
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end
end
