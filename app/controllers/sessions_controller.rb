class SessionsController < ApplicationController
  before_filter :require_no_user, only: [:new, :create]

  def new
  end

  def create
    user = User.find_by_username(params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to admin_petitions_url, flash: { success: 'Logged in!' }
    else
      flash.now.alert = 'Invalid e-mail address or password.'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, flash: { success: 'Logged out.' }
  end

end