class SessionsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :catch_not_found
  skip_before_action :authorized, only: [:new, :create, :welcome, :user]
  
  def new
  end

  def login
  end

  def create
    @user = User.find_by(email: params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      # log_in @user
      flash[:notice]="Logged in successfully."
      redirect_to '/welcome'
    else
      flash.now[:alert] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def page_requires_login
  end

  def destroy
    reset_session
    redirect_to login_path 
  end

  def catch_not_found(e)
      Rails.logger.debug("We had a not found exception.")
      flash.alert = e.to_s
      redirect_to sessions_path
    end
end
