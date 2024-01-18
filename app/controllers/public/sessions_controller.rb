# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  before_action :customer_state, only: [:create]

  def after_sign_in_path_for(resource)
    root_path
  end

　def customer_state
  　if customer = Customer.find_by(email: params[:customer][:email])
    　if customer.valid_password?(params[:customer][:password]) && customer.active_for_authentication? == false
      　flash[:error] = '退会済みです'
      　redirect_to new_customer_session_path
    　else
      　flash[:error] = 'パスワードが間違っているか、または未入力です'
    　end
  　else
    　flash[:error] = '必須項目を入力してください'
  　end
　end

  protected

  def authenticate_user
    user = warden.authenticate(params[:user], scope: :user)
    session[:user_id] = user.id
    redirect_to after_sign_in_path_for(user)
  end
end
