class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!
  paginates_per 10

  def top
    @orders = Order.page(params[:page])
    @order_count = @orders.count
  end

end
