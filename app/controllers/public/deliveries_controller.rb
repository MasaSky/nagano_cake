class Public::DeliveriesController < ApplicationController
  before_action :authenticate_customer!

  def index
    @delivery = Delivery.new
    @deliveries = Delivery.where(customer: current_customer)
  end

  def create
    @delivery = Delivery.new(delivery_params)
    @delivery.customer_id = current_customer.id
    if @delivery.save
      flash[:notice] = "配送先を登録しました"
      redirect_to deliveries_path
    else
      flash[:alert] = "配送先を登録できませんでした。"
      @deliveries = Delivery.where(customer_id: current_customer.id)
      redirect_to deliveries_path
    end
  end

  def edit
    @delivery = Delivery.find(params[:id])
  end

  def update
    @delivery = Delivery.find(params[:id])
    if @delivery.update(delivery_params)
      flash[:notice] = "配送先情報を更新しました"
      redirect_to deliveries_path
    else
      flash[:alert] = "配送先を登録できませんでした。"
      render :edit
    end
  end

  def destroy
    @delivery = Delivery.find(params[:id])
    @delivery.destroy
    redirect_to deliveries_path
  end

  private

  def delivery_params
    params.require(:delivery).permit(:customer_id, :attention, :postal_code, :address)
  end
end
