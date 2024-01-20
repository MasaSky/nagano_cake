# frozen_string_literal: true

class Admin::SessionsController < Devise::SessionsController

  protected

  def after_sign_in_path_for(resource)
    flash[:notice] = "管理者ページにログインしました"
    admin_homes_path
  end

  def after_sign_out_path_for(resource)
    flash[:notice] = "管理者ページにログアウトしました"
    new_admin_session_path
  end
end
