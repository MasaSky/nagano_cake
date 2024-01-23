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
  end


  def search_genres
    @genres = Genre.all
    @genre_name = params[:name]
    @items = Genre.find_by(name: @genre_name).items
  end
end
