class Admin::HomesController < ApplicationController

  def top
    @orders = Order.page(params[:page])
    @order_count = @orders.count
  end

end
