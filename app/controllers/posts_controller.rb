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

  private

  def post_params
    params.require(:post).permit(:content)
  end
end
