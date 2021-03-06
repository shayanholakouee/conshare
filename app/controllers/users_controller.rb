class UsersController < ApplicationController
  before_action :set_user, except: [:index, :new, :create]
  before_action :require_user , only: [:edit,:update, :show]
  before_action :require_same_user , only: [:edit, :update]
  before_action :admin, only: [:destroy]
  def index
    @user = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "New account created #{@user.username}"
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  def edit

  end

  def update
    if @user.update(user_params)
      flash[:success] = "#{@user.username} information updated"
      redirect_to root_path
    else
      render :edit
    end
  end

  def show

  end

  def destroy
    if @user.destroy
      flash[:warning] = "user deleted"
      redirect_to root_path
    else
      flash[:danger] = "action interrupted do it again"
      redirect_to root_path
    end
  end

  private

  def set_user
    @user = User.find_by(id: params[:id])
    unless @user
      flash[:danger] = "no user with that info"
      redirect_to root_path
    end
  end

  def user_params
    params.require(:user).permit(:username, :email , :password )
  end

  def require_same_user
    unless  current_user == @user
      flash[:danger] = "this is not your profile"
      redirect_to root_path
    end
  end

  def admin
    unless current_user.admin?
      flash[:danger] = "Not authorized action"
      redirect_to root_path
    end
  end

end
