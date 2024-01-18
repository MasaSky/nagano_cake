class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!
  before_action :setup_cart_item!, only: [:update, :create, :destroy, :destroy_all]
  include ApplicationHelper

  def index
    @cart_items = current_customer.cart_items
    @total_amount = @cart_items.inject(0) { |sum, cart_item| sum + cart_item.price }
  end

  def create
    @cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
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

  def destroy    #--- DELETE /cart_items/:id
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
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
