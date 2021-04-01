# frozen_string_literal: true

class SessionsController < Devise::SessionsController
  include InternalRedirect
  include Devise::Controllers::Rememberable
  include CurrentCart
  before_action :set_cart

  # replaced with :require_no_authentication_without_flash
  skip_before_action :require_no_authentication, only: %i[new create]

  prepend_before_action :store_redirect_uri, only: [:new]

  def new
    set_minimum_password_length

    super
  end

  def create
    super do |resource|
      # User has successfully signed in, so clear any unused reset token
      if resource.reset_password_token.present?
        resource.update(reset_password_token: nil,
                        reset_password_sent_at: nil)
      end

      # hide the signed-in notification
      flash[:notice] = nil
    end
  end

  def destroy
    super
    # hide the signed_out notice
    flash[:notice] = nil
  end

  private

  def require_no_authentication_without_flash
    require_no_authentication

    if flash[:alert] == I18n.t('devise.failure.already_authenticated')
      flash[:alert] = nil
    end
  end

  def user_params
    params.require(:user).permit(:login, :password, :remember_me, :otp_attempt, :device_response)
  end

  def stored_redirect_uri
    @redirect_to ||= stored_location_for(:redirect)
  end

  def store_redirect_uri
    redirect_uri =
      if request.referer.present? && (params['redirect_to_referer'] == 'yes')
        URI(request.referer)
      else
        URI(request.url)
      end

    # Prevent a 'you are already signed in' message directly after signing:
    # we should never redirect to '/users/sign_in' after signing in successfully.
    return true if redirect_uri.path == new_user_session_path

    redirect_to = redirect_uri.to_s if host_allowed?(redirect_uri)

    @redirect_to = redirect_to
    store_location_for(:redirect, redirect_to)
  end
end
