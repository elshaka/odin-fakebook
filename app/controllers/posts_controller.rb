class PostsController < ApplicationController
  def index
    @post = Post.new
    @posts = current_user.timeline_posts
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

  private

  def post_params
    params.require(:post).permit(:content)
  end
end
