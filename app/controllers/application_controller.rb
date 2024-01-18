class ApplicationController < ActionController::Base
    before_action :configure_authentication	#---現在のコントローラーが管理者用かどうかに基づいて適切な認証メソッド（authenticate_user! または authenticate_admin!）を呼び出

  private

  def configure_authentication
    if admin_controller?	#---Admin名前空間の下にあるかどうかを判定
      authenticate_admin!
    else
      authenticate_user! unless action_is_public?	#---コントローラーがhomesかつtopアクションではない場合にfalseが返りauthenticate_user!が実行
    end
  end

  def admin_controller?
    self.class.module_parent_name == 'Admin'
  end

  def action_is_public?		#---特定のアクションが認証が不要かどうかを判定
    controller_name == 'homes' && action_name == 'top'
  end
end
