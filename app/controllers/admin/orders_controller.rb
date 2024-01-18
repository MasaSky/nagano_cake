class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!
  include ApplicationHelper

  def index
    @orders = Order.all.page(params[:page]).per(10)
  end

  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items
  end

  def update
　　if @order.update(order_params)
  　　if @order.order_status == "入金確認"
    　@order.order_items.update_all(production_status: 1)
  　　end
　　end
    　flash[:notice] = "注文ステータスを変更しました"
    　redirect_to admin_order_path(@order)
  end

  private

  def order_params
    params.require(:order).permit(:order_status)
  end
end
