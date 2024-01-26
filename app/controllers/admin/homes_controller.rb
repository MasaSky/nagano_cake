class Admin::HomesController < ApplicationController

  def top
    @orders = Order.all
    @order_count = @orders.count
  end

end
