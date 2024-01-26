class Public::CustomersController < ApplicationController

  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      redirect_to customer_path(current_customer)
      flash[:notice] = "登録情報を更新しました。"
    else
      render :edit
    end
  end

  def info
    @customer = current_customer
  end

  def quit
    @customer = current_customer
  end

  def deactive
    @customer = current_customer
    @customer.update(is_active: false)
    reset_session
    flash.clear
    redirect_to root_path
    flash[:notice] = "退会完了しました。"
  end

  private

  def customer_params
      params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telphone_number, :email)
  end
end
