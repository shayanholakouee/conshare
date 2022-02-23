class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = "Login Successfully"
      redirect_to user_path(user)
    else
      flash.now[:danger] = "wrong info"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "Logout success"
    redirect_to root_path
  end
end
