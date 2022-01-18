class ItemsController < ApplicationController
  def new
    @item = Item.new
  end

  def show
    @item = Item.find(params[:id])
  end

  def index
    @items = Item.all
    @ItemsAllSum = Item.all.sum(:price)
  end

  def create 
    @item = Item.new(item_params)
    if @item.save
      flash[:success] = "欲しがりさんめ！"
      redirect_to '/items/index'
    else
      flash[:danger] = "何ゆーてますの？"
      render 'new'
    end
  end
  
    def destroy
      @item = Item.find(params[:id])
      @item.destroy
      redirect_to '/items/index'
    end

  def search_date
      @search_dates = Item.find_by(params[:id]).buy_month.to_s
  end

  def month_of_buy
    @month_of_buy = Item.where(created_at: @seach_date.in_time_zone.all_year)
  end

  helper_method :search_date, :month_of_buy

  private

  def item_params
    params.require(:item).permit(:name, :price, :buy_month)
  end
end
