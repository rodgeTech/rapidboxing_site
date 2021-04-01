# frozen_string_literal: true

module Api
  module V1
    module Settings
      class WeightShippingRatesController < BaseController
        skip_before_action :authenticate_user!

        def index
          rates = WeightShippingRate.order(created_at: :desc)
          render json: WeightShippingRateSerializer.new(rates).serialized_json
        end
      end
    end
  end
end
