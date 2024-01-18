class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!
  include ApplicationHelper

  def new
    @order = Order.new
    @deliveries = Delivery.where(customer: current_customer)
  end

  def confirm
    @cart_items = current_customer.cart_items
    @order = Order.new(customer: current_customer, payment_method: params[:order][:payment_method])

    if params[:order][:delivery_option] == "address"    #---enum 0 会員情報
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.attention = current_customer.last_name + current_customer.first_name

    elsif params[:order][:delivery_option] == "shipping_address"    #---enumm 1 配送先情報
      ship = Delivery.find(params[:order][:delivery_id])
      @order.attention = ship.attention
      @order.postal_code = ship.postal_code
      @order.address = ship.address

    elsif params[:order][:delivery_option] == "new_address"    #---enum 2 配送先新規
      @order.attention = params[:order][:attention]
      @order.postal_code = params[:order][:postal_code]
      @order.address = params[:order][:address]

      unless @order.valid? == true
        @deliveries = Delivery.where(customer: current_customer)
        render :new
      end
    end
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      current_customer.cart_items.each do |cart_item|
        cart_item = CartItem.find_by(item_id: cart_item.item_id)
        OrderItem.create!(order: @order, item: cart_item.item, price: cart_item.price, quantity: cart_item.quantity)
      end
      current_customer.cart_items.destroy_all
      redirect_to orders_complete_path
    else
      render :new
    end
  end

  def complete
    @order = Order.find(params[:id])
    @order.complete!
    redirect_to orders_path, notice: '注文を完了しました'
  end

  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :item_id, :quantity, :grand_total, delivery_id, :attention, :postal_code, :address, :payment_method)
  end
end
