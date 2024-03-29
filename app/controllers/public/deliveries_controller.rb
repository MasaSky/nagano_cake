class Public::DeliveriesController < ApplicationController

  def index
    @delivery = Delivery.new
    @customer = current_customer
    @deliveries = @customer.deliveries.page(params[:page])
  end

  def create
    @delivery = Delivery.new(delivery_params)
    @delivery.customer_id = current_customer.id
    if @delivery.save
      flash[:notice] = "配送先を登録しました。"
      redirect_to deliveries_path
    else
      @deliveries = Delivery.where(customer_id: current_customer.id)
      render :index
    end
  end

  def edit
    @delivery = Delivery.find(params[:id])
  end

  def update
    @delivery = Delivery.find(params[:id])
    if @delivery.update(delivery_params)
      flash[:notice] = "配送先情報を更新しました。"
      redirect_to deliveries_path
    else
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
