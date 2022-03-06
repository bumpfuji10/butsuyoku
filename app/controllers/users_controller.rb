class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @ItemsAllSum = Item.all.sum(:price)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to current_user  ##あとで修正
    else
      redirect_to "/" #後で修正
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "BUTUSYOKUへようこそ"
      redirect_to @user
    else
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
