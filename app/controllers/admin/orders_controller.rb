class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!
  include ApplicationHelper


  def show
    @order = Order.find(params[:id])
    @orders = Order.all
    @order_items = OrderItem.where(order_id: @order.id)
    @order_new = Order.new
    @order_item = OrderItem.find(params[:id])

    @order_status_key = Order.order_statuses
    @product_status_key = OrderItem.product_statuses
    @customer = @order.customer
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    if @order.order_status == "入金確認"
     @order.order_items.update_all(product_status: 1)
    elsif @order.order_status == "製作中"
     @order.order_items.update_all(product_status: 2)
    end
    redirect_back(fallback_location: root_path)
  end

  private

  def order_params
    params.require(:order).permit(:order_status, :product_status)
  end

end