# frozen_string_literal: true

class Public::RegistrationsController < Devise::RegistrationsController

  def after_sign_up_path_for(resource)
    root_path
  end

end