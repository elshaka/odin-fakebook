class NotificationsController < ApplicationController
  def index
    @notifications = current_user.notifications.unread

    respond_to do |format|
      format.js
    end
  end

  def mark_as_read
    notification = Notification.find params[:id]
    notification.mark_as_read

    redirect_to notification.url
  end

  def mark_all_as_read
    current_user.notifications.update_all(read: true)
    @notifications = []

    respond_to do |format|
      format.js { render :index }
    end
  end
end
