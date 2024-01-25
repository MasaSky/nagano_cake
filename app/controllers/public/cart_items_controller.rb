class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!
  include ApplicationHelper

  def index
    @cart_items = current_customer.cart_items.all
    @total_amount = CartItem.total_amount(current_customer)
  end

  def create
    if current_customer.cart_items.find_by(item_id: cart_item_params[:item_id])
      if cart_item_params[:quantity].blank?
        @item = Item.find(cart_item_params[:item_id])
        @genres = Genre.all
        @cart_item = CartItem.new
        flash[:notice] = "個数を入力してください"
        redirect_to item_path(@item.id)
      else
        @cart_item = current_customer.cart_items.find_by(item_id: cart_item_params[:item_id])
        @cart_item.quantity = @cart_item.quantity + cart_item_params[:quantity].to_i
        @cart_item.save
        redirect_to cart_items_path
      end
    else
      if cart_item_params[:quantity].blank?
        @item = Item.find(cart_item_params[:item_id])
        @genres = Genre.all
        @cart_item = CartItem.new
        flash[:notice] = "個数を入力してください"
        redirect_to item_path(@item.id)
      else
        @cart_item = current_customer.cart_items.new(cart_item_params)
        @cart_item.save
        redirect_to cart_items_path
      end
    end
  end

  def update
    CartItem.find_by(id: params[:id]).update(cart_item_params)
    redirect_to cart_items_path
  end

  def destroy
    CartItem.find(params[:id]).destroy
    redirect_to cart_items_path
  end

  def destroy_all
    @cart_items = current_customer.cart_items.all
    @cart_items.destroy_all
    flash[:notice] = 'カートを空にしました'
    redirect_to cart_items_path
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:customer_id, :item_id, :quantity)
  end
end
