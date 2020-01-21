class PostsController < ApplicationController
  def index
    @user = current_user
  end

  def show
    @post = Post.find_by(id: params[:id])
  end
end
