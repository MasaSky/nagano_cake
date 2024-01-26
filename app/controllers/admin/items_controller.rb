class Admin::ItemsController < ApplicationController

  def index
    @items = Item.page(params[:page])
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @genres = Genre.all
    if @item.save
      flash[:notice] = "商品を登録しました"
      redirect_to admin_item_path(@item)
    else
      render :new
    end
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
      flash[:notice] = "商品を更新しました"
      redirect_to admin_item_path(@item)
    else
      render :edit
    end
  end

  def search_word
    @genres = Genre.all
  end

  def search_genres
    @genres = Genre.all
    @genre_name = params[:name]
    @items = Genre.find_by(name: @genre_name).items
  end

  private

  def item_params
    params.require(:item).permit(:genre_id, :image, :name, :introduction, :unit_price, :is_active)
  end
end