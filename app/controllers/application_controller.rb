class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_user
    redirect_to root_url, alert: 'You must be logged in to access this area.' unless current_user
  end

  def require_no_user
    case
    when current_user.try(:admin?) then redirect_to admin_petitions_url
    when current_user.present?     then redirect_to petitions_url
    end
  end

  def require_admin
    redirect_to root_url, alert: 'You must be an admin to access this area.' unless current_user.try(:admin?)
  end

  def set_notifications
    return unless current_user
    number_to_show = current_user.unseen_notifications.count > 5 ? current_user.unseen_notifications.count : 5
    @notifications = current_user.notifications.limit(number_to_show)
  end

  def redirect_to_invitation_request
    redirect_to new_invitation_request_url if Rails.env.production? and !current_user
  end

  helper_method :current_user, :require_user
end
