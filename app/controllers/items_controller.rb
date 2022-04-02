class ItemsController < ApplicationController
  before_action :search

  def home
  end

  def about
  end

  def new
    if current_user
      @item = Item.new
    else redirect_to login_path
      flash[:danger] = "ログインしてください"
    end
  end

  def create
    @item = current_user.items.build(item_params)
    if @item.save
      flash[:success] = '登録しました'
      redirect_to index_path
    else
      render 'new'
    end
  end

  def index
    if current_user
      @items = Item.where(user_id: current_user.id).order(buy_month: :asc)
      @ItemsAllSum = @items.all.sum(:price)
    else
      redirect_to login_path
      flash[:danger] = "ログインしてください"
    end
  end

  def edit
    if current_user
      @item = Item.find(params[:id])
    else
      redirect_to login_path
      flash[:danger] = "ログインしてください"
    end
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to index_path
      flash[:success] = "編集しました"
    else
      redirect_to "/items/#{@item.id}/edit"
      flash[:damger] = "編集に失敗しました"
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    flash[:danger] = "ナイスです！"
    redirect_to index_path
  end

  def search
    if logged_in?
      @q = current_user.items.ransack(params[:q])
      @items = @q.result(distinct: true).order(buy_month: :asc)
      @ItemsAllSumSearch = @items.all.sum(:price)
    end
  end

    private

      def item_params
        params.require(:item).permit(:name, :price, :buy_month, :reason, :user_id)
      end

end
