# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  before_action :configure_permitted_parameters, if: :devise_controller?


  def after_sign_in_path_for(resource)
    customers_path
  end
  
  def after_sign_out_path_for(resource)
    root_path
  end
  

  protected

  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password])
  end
end
