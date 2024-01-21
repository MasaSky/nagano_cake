class Public::ItemsController < ApplicationController
  def index
    @items = Item.all
    @genres = Genre.all
  end

  def show
    @item = Item.find(params[:id])
    @cart_item=CartItem.new
    @genres = Genre.all
  end

  def search_word
    @genres = Genre.all
    @q = Search.ransack(params[:q])
    @results = @q.result(distinct: true)
  end

  def search_genres
    @genre = Genre.find(params[:id])
    @items = @genre.items.all
  end
end