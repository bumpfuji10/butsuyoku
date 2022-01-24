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
      search_date = Time.new(2022, 1, 1)
    end

    def part_month_item
      part_month_item = Item.where(buy_month: search_date.beginning_of_month..search_date.end_of_month)
    end

    def part_month_item_sum
      part_month_item_sum = part_month_item.all.sum(:price)
    end
    
    helper_method :search_date, :part_month_item, :part_month_item_sum
    private

      def item_params
        params.require(:item).permit(:name, :price, :buy_month)
      end
    end
