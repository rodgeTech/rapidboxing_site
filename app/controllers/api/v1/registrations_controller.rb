# frozen_string_literal: true

class Api::V1::RegistrationsController < DeviseTokenAuth::RegistrationsController
  def create
    build_resource

    unless @resource.present?
      raise DeviseTokenAuth::Errors::NoResourceDefinedError,
            "#{self.class.name} #build_resource does not define @resource,"\
            ' execution stopped.'
    end

    # if whitelist is set, validate redirect_url against whitelist
    if blacklisted_redirect_url?(@redirect_url)
      return render_create_error_redirect_url_not_allowed
    end

    @resource.skip_confirmation!

    if @resource.save
      yield @resource if block_given?

      if active_for_authentication?
        # email auth has been bypassed, authenticate user
        @token = @resource.create_token
        @resource.save!
        update_auth_header
      end

      render_create_success
    else
      clean_up_passwords @resource
      render_create_error
    end
  end
end
