class ItemsController < ApplicationController
  before_action :search

  def about
  end

  def show
    @item = Item.find(params[:id])
  end


  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to index_path
    else
      redirect_to "/"
    end
  end

  def new
    @item = Item.new
  end

  def index
    @items = Item.all.order(buy_month: :asc)
    @ItemsAllSum = Item.all.sum(:price)
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:success] = "欲しがりさんめ！"
      redirect_to index_path
    else
      flash[:danger] = "何ゆーてますの？"
      render 'new'
    end
  end

    def destroy
      @item = Item.find(params[:id])
      @item.destroy
      redirect_to index_path
    end

    def search
      @q = Item.ransack(params[:q])
      @items = @q.result(distinct: true).order(buy_month: :desc)
      @ItemsAllSumOnSearch = @items.all.sum(:price)
    end

    private

      def item_params
        params.require(:item).permit(:name, :price, :buy_month, :reason)
      end

end
