class Admin::CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update]
  
  def index
    @customers = Customer.page(params[:page])
  end

  def show
    @order = @customer.orders
  end

  def edit
  end

  def update
    if @customer.update(customer_params)
      redirect_to admin_customer_path(@customer)
      flash[:notice] = "会員情報を更新しました。"
    else
      render :edit
    end
  end


  private
  
  def set_customer
    @customer = Customer.find(params[:id])
  end

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telphone_number, :email, :is_active)
  end
end
