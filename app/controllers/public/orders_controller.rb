class Public::OrdersController < ApplicationController
  before_action :ensure_cart_items, only: [:new, :confirm, :create]
  before_action :set_order_id, only: [:complete]

  def new
    @order = Order.new
    @deliveries = Delivery.where(customer: current_customer)
  end

  def confirm
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @total_amount = CartItem.total_amount(current_customer)
    @grand_total = CartItem.total_amount(current_customer) + @order.freight
    if params[:order][:delivery_option] == '0'
      @order.delivery_form(current_customer)

    elsif params[:order][:delivery_option] == '1'
      @delivery = Delivery.find(params[:order][:delivery_id])
      @order.delivery_form(@delivery)

    elsif params[:order][:delivery_option] == '2'
      @order.attention = params[:order][:attention]
      @order.postal_code = params[:order][:postal_code]
      @order.address = params[:order][:address]
    end
      unless @order.valid? == true
      flash[:notice] = "入力情報に不備があります。"
      @deliveries = Delivery.where(customer: current_customer)
      render :new
      end
  end

  def create
    @order = current_customer.orders.new(order_params)
    @order.save
    @order.create_order_items(current_customer)
    redirect_to complete_orders_path
  end

  def complete
    @order_new = Order.find(@order_id)
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

  def ensure_cart_items
    @cart_items = current_customer.cart_items.includes(:item)
    redirect_to items_path unless @cart_items.first
  end

  def set_order_id
    @order_id = current_customer.orders.last.id
  end
end
