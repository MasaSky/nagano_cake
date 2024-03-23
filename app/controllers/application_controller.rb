class ApplicationController < ActionController::Base
  before_action :configure_authentication
  before_action :set_search
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def set_search
    @q = Item.ransack(params[:q])
    @items = @q.result(distinct: true)
  end

  def configure_authentication
    if admin_controller?
      authenticate_admin!
    else
      authenticate_user! unless admin_controller?
    end
  end

  def admin_controller?
    self.class.module_parent_name == 'Admin'
  end

  def public_controller?
    self.class.module_parent_name == 'Public'
  end

  def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telphone_number])
  end
end
