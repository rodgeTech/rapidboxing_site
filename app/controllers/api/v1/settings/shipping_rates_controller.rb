# frozen_string_literal: true

module Api
  module V1
    module Settings
      class ShippingRatesController < BaseController
        skip_before_action :authenticate_user!

        def index
          if params[:all].present?
            rates = ShippingRate.order(created_at: :desc)
            render json: ShippingRateSerializer.new(rates).serialized_json
          else
            rate_method = ShippingSetting.rate_method
            if rate_method == 'weight'
              rates = WeightShippingRate.order(created_at: :desc)
              render json: WeightShippingRateSerializer.new(rates).serialized_json
            elsif rate_method == 'price'
              rates = PriceShippingRate.order(created_at: :desc)
              render json: PriceShippingRateSerializer.new(rates).serialized_json
            end
          end
        end
      end
    end
  end
end
