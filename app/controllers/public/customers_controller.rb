class Public::CustomersController < ApplicationController
  before_action :set_current_customer

  def show
  end

  def edit
  end

  def update
    if @customer.update(customer_params)
      redirect_to info_path(current_customer)
      flash[:notice] = "登録情報を更新しました。"
    else
      render :edit
    end
  end

  def quit
  end

  def deactive
    @customer.update(is_active: false)
    reset_session
    flash.clear
    redirect_to root_path
    flash[:notice] = "退会完了しました。"
  end

  private
  
  def set_current_customer
    @customer = current_customer
  end

  def customer_params
      params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telphone_number, :email)
  end
end
