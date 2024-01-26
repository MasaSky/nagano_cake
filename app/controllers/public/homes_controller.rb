class Public::HomesController < ApplicationController

  def top
    @items = Item.all.limit(4).order("created_at DESC")
    @genres = Genre.all
  end

  def about
    @items = Item.all.limit(1).order("created_at DESC")
  end
end