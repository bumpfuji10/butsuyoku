class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    if !current_user
      redirect_to login_path
      flash[:danger] = "ログインしてください"
    end
  end

  def edit
    @user = User.find(params[:id])
    if !current_user
      redirect_to login_path
      flash[:danger] = "ログインしてください"
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "編集しました"
      redirect_to current_user
    else
      flash[:danger] = "編集に失敗しました"
      redirect_to "/users/#{current_user.id}/edit"
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "BUTSUYOKUへようこそ"
      redirect_to @user
    else
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :item_id)
  end

  def logged_in_user
    unless logged_in?
      flash[:danger] = "ログインしてください"
      redirect_to login_url
    end
  end
end
