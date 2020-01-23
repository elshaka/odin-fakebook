class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def send_friend_request
    current_user.friendships.create friend_id: params[:id]
  end

  def accept_friend_request
    current_user.reverse_friendships.find_by(id: params[:id])
  end
end
