class Admin::OrdersController < ApplicationController
  before_action :ensure_order, only: [:show, :update]
  
  def index
    @customer = Customer.find(params[:customer_id])
    @orders = @customer.orders.page(params[:page]).reverse_order
    @order_count = @customer.orders.count
  end

  def show
    @orders = Order.all
    @order_items = OrderItem.where(order_id: @order.id)
    @order_new = Order.new
    @order_item = OrderItem.find(params[:id])
    @total_amount = OrderItem.total_amount(@order)
    @order_status_key = Order.order_statuses
    @product_status_key = OrderItem.product_statuses
    @customer = @order.customer
  end

  def update
    @order.update(order_params)
    if @order.order_status == "入金確認"
     @order.order_items.update_all(product_status: 1)
    elsif @order.order_status == "製作中"
     @order.order_items.update_all(product_status: 2)
    end
    redirect_back(fallback_location: root_path)
    flash[:notice] = "注文ステータスを更新しました。"
  end

  private

  def order_params
    params.require(:order).permit(:order_status, :product_status, :customer_id)
  end

  def ensure_order
    @order = Order.find(params[:id])
  end
end