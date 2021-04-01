# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit

  before_action :configure_permitted_parameters, if: :devise_controller?

  protect_from_forgery with: :null_session, if: -> { request.format.json? }

  rescue_from ActiveRecord::RecordNotFound, with: :render_404

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  around_action :rescue_from_fk_contraint, only: [:destroy]

  def rescue_from_fk_contraint
    yield
  rescue ActiveRecord::InvalidForeignKey
    # Flash and render, render API json error... whatever
    flash[:alert] = 'Failed, that record is referenced somewhere'
    redirect_back(fallback_location: root_path)
  end

  def user_not_authorized
    flash[:alert] = 'You are not authorized to do that.'
    redirect_to root_path
  end

  def not_found
    render_404
  end

  def route_not_found
    not_found
  end

  def render_404
    respond_to do |format|
      format.html { render 'errors/not_found', layout: 'errors', status: 404 }
      # Prevent the Rails CSRF protector from thinking a missing .js file is a JavaScript file
      format.js { render json: '', status: :not_found, content_type: 'application/json' }
      format.any { head :not_found }
    end
  end

  def redirect_to_back_or_default(default = root_url, *args)
    if request.env['HTTP_REFERER'].present? && request.env['HTTP_REFERER'] != request.env['REQUEST_URI']
      redirect_to :back, *args
    else
      redirect_to default, *args
    end
  end

  protected

  def configure_permitted_parameters
    # devise_parameter_sanitizer.permit(:account_update) do |u|
    #   u.permit(:name,
    #            :email,
    #            :password,
    #            :password_confirmation,
    #            :current_password)
    # end
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[email name password])
    devise_parameter_sanitizer.permit(:account_update,
                                      keys: %i[email name password
                                               password_confirmation
                                               current_password])
  end
end
