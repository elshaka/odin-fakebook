class UsersController < ApplicationController
  before_action :set_user, except: [:index]

  def index
    @users = User.all
  end

  def show; end

  def send_friend_request
    current_user.friendships.create friend_id: params[:id]

    respond_to do |format|
      format.js { render :refresh_user_friendship_actions }
    end
  end

  def cancel_friend_request
    current_user.friendships.find_by(friend_id: params[:id], confirmed: false)&.destroy

    respond_to do |format|
      format.js { render :refresh_user_friendship_actions }
    end
  end

  def accept_friend_request
    current_user.reverse_friendships.find_by(user_id: params[:id])&.update_attribute(:confirmed, true)

    respond_to do |format|
      format.js { render :refresh_user_friendship_actions }
    end
  end

  def reject_friend_request
    current_user.reverse_friendships.find_by(user_id: params[:id], confirmed: false)&.destroy

    respond_to do |format|
      format.js { render :refresh_user_friendship_actions }
    end
  end

  def delete_friend
    friendship = current_user.friendships.find_by(friend_id: params[:id], confirmed: true)
    friendship ||= current_user.reverse_friendships.find_by(user_id: params[:id], confirmed: true)
    friendship&.destroy

    respond_to do |format|
      format.js { render :refresh_user_friendship_actions }
    end
  end

  private

  def set_user
    @user = User.find params[:id]
  end
end
