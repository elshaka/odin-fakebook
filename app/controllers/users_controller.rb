class UsersController < ApplicationController
  before_action :set_user, except: [:index]

  def index
    @users = User.all
  end

  def show; end

  def send_friend_request
    current_user.send_friend_request(@user)

    respond_to do |format|
      format.js { render :refresh_user_friendship_actions }
    end
  end

  def cancel_friend_request
    current_user.cancel_friend_request(@user)

    respond_to do |format|
      format.js { render :refresh_user_friendship_actions }
    end
  end

  def accept_friend_request
    current_user.accept_friend_request(@user)

    respond_to do |format|
      format.js { render :refresh_user_friendship_actions }
    end
  end

  def reject_friend_request
    current_user.reject_friend_request(@user)

    respond_to do |format|
      format.js { render :refresh_user_friendship_actions }
    end
  end

  def delete_friend
    current_user.delete_friend(@user)

    respond_to do |format|
      format.js { render :refresh_user_friendship_actions }
    end
  end

  private

  def set_user
    @user = User.find params[:id]
  end
end
