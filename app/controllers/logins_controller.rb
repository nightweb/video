class LoginsController < ApplicationController
  def new
    redirect_to posts_path if user_logged?
  end

  def create
    user = User.check_user(params[:username]).first
    # abort(user.inspect)
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Your are logged"
      redirect_to :back
    else
      flash[:danger] = "Email or password are incorrect"
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to posts_path
  end
end
