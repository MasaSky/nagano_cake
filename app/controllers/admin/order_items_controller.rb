class Admin::OrderItemsController < ApplicationController
  include ApplicationHelper

  def update
    @order_item = OrderItem.find(params[:id])
    @order_item.update(order_item_params)
    if @order_item.product_status == "製作中"
      @order_item.order.update(order_status: 2)
    elsif OrderItem.where(product_status: "製作完了", order_id: @order_item.order_id).count == @order_item.order.order_items.count
      @order_item.order.update(order_status: 3)
    end
    redirect_back(fallback_location: root_path)
  end

  def order_item_params
    params.require(:order_item).permit(:product_status, :order_id)
  end

end