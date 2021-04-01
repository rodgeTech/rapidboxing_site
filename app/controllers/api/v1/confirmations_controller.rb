# frozen_string_literal: true

class Api::V1::ConfirmationsController < DeviseTokenAuth::ConfirmationsController
  def create
    unless resource_params[:email]
      return render json: {
        success: false,
        errors: ['You must provide an email address.']
      }, status: 400
    end

    unless params[:redirect_url]
      return render json: {
        success: false,
        errors: ['Missing redirect url.']
      }, status: 400
    end

    email = if resource_class.case_insensitive_keys.include?(:email)
              resource_params[:email].downcase
            else
              resource_params[:email]
            end

    q = "uid = ? AND provider='email'"

    @resource = resource_class.where(q, email).first

    errors = nil

    if @resource
      @resource.send_confirmation_instructions(
        redirect_url: params[:redirect_url],
        client_config: params[:config_name]
      )
    else
      errors = ["Unable to find user with email '#{email}'."]
    end

    if errors
      render json: {
        success: false,
        errors: errors
      }, status: 400
    else
      render json: {
        status: 'success',
        data: @resource.as_json
      }
    end
  end
end
