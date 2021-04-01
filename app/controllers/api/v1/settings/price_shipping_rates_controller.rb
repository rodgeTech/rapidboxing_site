# frozen_string_literal: true

module Api
  module V1
    module Settings
      class PriceShippingRatesController < BaseController
        def index
          rates = PriceShippingRate.order(created_at: :desc)
          render json: PriceShippingRateSerializer.new(rates).serialized_json
        end
      end
    end
  end
end
