class ApplicationController < ActionController::Base
    before_action :search

    def search
        @search = Item.ransack(params[:q])
        @items = @search.result
    end

end
