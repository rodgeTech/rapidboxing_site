# frozen_string_literal: true

class RegistrationsController < Devise::RegistrationsController
  layout :choose_layout, only: %i[edit update]
  include CurrentCart

  invisible_captcha only: [:create]
  before_action :set_cart

  def choose_layout
    return 'admin' if current_user.admin?
  end

  protected

  def after_update_path_for(_resource)
    edit_user_registration_path
  end

  def sign_up_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
