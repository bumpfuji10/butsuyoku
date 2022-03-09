class ItemsController < ApplicationController
  before_action :search

  def home
  end

  def about
  end

  def new
    @item = Item.new
  end

  def create
    @item = current_user.items.build(item_params)
    if @item.save
      flash[:success] = "欲しがりさんめ！"
      redirect_to index_path
    else
      flash[:danger] = "何ゆーてますの？"
      render 'new'
    end
  end

  def index
    @items = Item.where(user_id: current_user.id).order(buy_month: :asc)
    @ItemsAllSum = @items.all.sum(:price)
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

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    flash[:danger] = "削除しました"
    redirect_to index_path
  end

  def search
      @q = current_user.items.ransack(params[:q])
      @items = @q.result(distinct: true).order(buy_month: :desc)
      @ItemsAllSumOnSearch = @items.all.sum(:price)
  end

  ## def index
    ## @q = current_user.task.ransack(params[:q])
    ## @task = @q.result(distinct: true).recent
  ## end

    private

      def item_params
        params.require(:item).permit(:name, :price, :buy_month, :reason, :user_id)
      end

end
