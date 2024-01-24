class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!
  include ApplicationHelper

  def index
    @cart_items = current_customer.cart_items.all
    @cart_item = CartItem.new
    @total_amount = CartItem.total_amount(current_customer)
  end

  def create
    @cart_item = current_customer.cart_items.new(cart_item_params)
    if @cart_item.present?
      @cart_item.quantity += params[:cart_item][:quantity].to_i
      @cart_item.save
      flash[:notice_1] = "数量を変更しました"
    else
      @cart_item = CartItem.new(cart_item_params)
      @cart_item.save
      flash[:notice_] = "商品をカートにいれました"
    end
    redirect_to cart_items_path
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
