class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!

  def top
    @orders = Orders.includes(:order_items, :user).all
    @orders = @orders.paginate(page: params[:page], per_page: 10)

    @order_dates = @orders.map { |order| order.created_at }
    @order_customer_names = @orders.map { |order| order.customer_names }
    @order_quantities = @orders.map { |order| order.order_items.sum(:quantity) }
    @order_statuses = @orders.map { |order| order.order_status }
  end
end
