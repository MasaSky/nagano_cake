class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!
  include ApplicationHelper

  def index
    @cart_items = current_customer.cart_items
    if @cart_items.present?
       @subtotal = total_amount(@cart_items)
    else
       @subtotal = 0
    end
  end

  def create
    @cart_item = current_customer.cart_items.new(cart_item_params)
    if @cart_item.present?
      @cart_item.quantity += params[:cart_item][:quantity].to_i
      @cart_item.save
      flash[:notice] = "数量を変更しました"
    else
      @cart_item = CartItem.new(cart_item_params)
      @cart_item.save
      flash[:notice] = "商品をカートにいれました"
    end
    redirect_to cart_items_path
  end

  def update
    CartItem.find_by(id: params[:id]).update(cart_item_params)
    redirect_to cart_items_path
  end

  def destroy
    CartItem.find(params[:id]).destroy
　　flash[:notice] = "カートから１商品を削除しました"
    redirect_to cart_items_path
  end

  def destroy_all    #--- DELETE /cart_items/cart_items
    CartItem.destroy_all(current_customer.id)
    flash[:notice] = 'カートを空にしました'
    redirect_to cart_items_path
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:customer_id, :item_id, :quantity)
  end
end
