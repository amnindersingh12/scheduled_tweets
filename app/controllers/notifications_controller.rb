class NotificationsController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token

  def index
    @notifications = Notification.find_recipient(current_user).unread
  end
end
