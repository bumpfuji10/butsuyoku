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
      @item = Item.find_by(params[:id])
      if !@item.nil?
      @search_date = @item.buy_month
      end
    end



    def month
      if !@search_date.nil?
        @months = Item.where(created_at: @search_date.beginning_of_month..@search_date.end_of_month)
      end
    end
    
    helper_method :search_date, :month
    private

      def item_params
        params.require(:item).permit(:name, :price, :buy_month)
      end
    end
