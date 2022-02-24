class UsersController < ApplicationController
  before_action :set_user, except: [:index, :new, :create]
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
      redirect_to root_path
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

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email , :password )
  end

end
