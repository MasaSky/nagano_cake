class Public::HomesController < ApplicationController
  def top
    @items = Item.all.order(id: :desc).limit(4)
  end
end
