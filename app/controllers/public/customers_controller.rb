class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!

  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end

  def update
    customer = current_customer
    if customer.update(customer_params)
      redirect_to customer, notice: '会員情報を更新しました'
    else
      render :show
    end
  end

  def info
    @customer = current_customer
  end

  def quit
    @customer = current_customer
  end

def deactive	#--- PATCH /customers/:id/deactive
  customer = current_customer
  if confirm('退会しますか？')
    customer.update(is_active: false)
    reset_session
    flash.clear
    redirect_to root_path, notice: '退会しました'
  else
    redirect_back(fallback_location: root_path)
  end
end

  private

  def customer_params
      params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telphone_number, :email)
  end
end
