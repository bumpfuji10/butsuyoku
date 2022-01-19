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
      @search_date = Item.find_by(params[:id]).buy_month.strftime('%Y年%m月%d日')
    end

    # def part_month
      # @item = Item.find_by(name: "f")
      # @search_date = item.buy_month.to_s
      # Item.where(created_at: @search_date.in_time.zone.all_month)
    # end
    
    helper_method :search_date
    private

      def item_params
        params.require(:item).permit(:name, :price, :buy_month)
      end
    end
