class Public::ItemsController < ApplicationController
  def index
    @items = Item.page(params[:page]).per(10)
  end

  def show
    @item = Item.find(params[:id])
    @cart_item=CartItem.new
  end

  def search_word
    @genres = Genre.all
    @q = Search.ransack(params[:q])
    @results = @q.result(distinct: true)
  end

  def search_genres
    @genres = Genre.all
    @search_genre = params[:genre]
    @items = Genre.where(genre: @search_genre).all
  end
end