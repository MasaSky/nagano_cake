class Admin::OrderItemsController < ApplicationController
  before_action :authenticate_admin!
  include ApplicationHelper

  def update
    @order_item = OrderItem.find(params[:id])
    @order_items = @order_item.order.order_items
    if @order_item.update(order_item_params)
      case @order_item.production_status
      when "製作中"
        @order_item.order.update(order_status: 2)
      when "製作完了"
        @order_items.each do |order_item|
          if order_item.production_status != "製作完了"
            return render :show
          end
        end
        @order_item.order.update(order_status: 3)
      end
      flash[:notice] = "製作ステータスを変更しました"
      redirect_to admin_order_path(@order_item.order)
    else
      render :show
    end
  end

  private

  def order_item_params
    params.require(:order_item).permit(:production_status)
  end
end