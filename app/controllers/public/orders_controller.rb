class Public::OrdersController < ApplicationController
  include ApplicationHelper

  def new
    @order = Order.new
    @deliveries = Delivery.where(customer: current_customer)
  end

  def confirm
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    if params[:order][:delivery_option] == '0'
      @order.attention = current_customer.last_name + current_customer.first_name
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address

    elsif params[:order][:delivery_option] == '1'
      @delivery = Delivery.find(params[:order][:delivery_id])
      @order.attention = @delivery.attention
      @order.postal_code = @delivery.postal_code
      @order.address = @delivery.address

    elsif params[:order][:delivery_option] == '2'
      @order.attention = params[:order][:attention]
      @order.postal_code = params[:order][:postal_code]
      @order.address = params[:order][:address]
    end
     @cart_items = current_customer.cart_items.all
     @total_amount = CartItem.total_amount(current_customer)
     @grand_total = CartItem.total_amount(current_customer) + @order.freight
     unless @order.valid? == true
     render :confirm
     end
  end

  def create
    @order = Order.new(order_params)
    unless @order.invalid? == true
    @order.save
    @cart_items = current_customer.cart_items.all
      @cart_items.each do |cart_item|
      @order_items = OrderItem.new
      @order_items.order_id = @order.id
      @order_items.item_id = cart_item.item.id
      @order_items.price = cart_item.item.price
      @order_items.quantity = cart_item.quantity
      @order_items.product_status = 0
      @order_items.save
      end
      CartItem.destroy_all
      redirect_to complete_orders_path
    else
      @cart_items = current_customer.cart_items.all
      @order = Order.new(order_params)
      @total_amount = OrderItem.total_amount(@order)
      render :confirm
      flash[:notice] = "注文を完了できません。"
    end
  end

  def complete
    @order_id = current_customer.id
    @order = Order.find(@order_id)
    @delivery = Delivery.new
  end

  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items
    @total_amount = OrderItem.total_amount(@order)
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :attention, :postal_code, :address, :freight, :grand_total, :payment_method, :order_status)
  end

end
