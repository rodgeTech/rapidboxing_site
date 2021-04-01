# frozen_string_literal: true

module Api
  module V1
    module Settings
      class LegalsController < BaseController
        skip_before_action :authenticate_user!

        def show
          render json: {
            refund_policy: LegalSetting.refund_policy,
            shipping_policy: LegalSetting.shipping_policy,
            delivery_policy: LegalSetting.delivery_policy,
            privacy_policy: LegalSetting.privacy_policy,
            terms_of_service: LegalSetting.terms_of_service
          }, status: :ok
        end
      end
    end
  end
end
