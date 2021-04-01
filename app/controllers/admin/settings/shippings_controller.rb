# frozen_string_literal: true

module Admin
  module Settings
    class ShippingsController < BaseController
      before_action :get_setting, only: %i[edit update]

      def show
        @weight_shipping_rates = WeightShippingRate.order(created_at: :desc)
        @price_shipping_rates = PriceShippingRate.order(created_at: :desc)
      end

      def create
        setting_params.keys.each do |key|
          ShippingSetting.send("#{key}=", setting_params[key].strip) unless setting_params[key].nil?
        end
        redirect_to admin_settings_shipping_path,
                    flash: { notice: 'Setting was successfully updated.' }
      end

      def setting_params
        params.require(:shipping_setting).permit(:rate_method)
      end
    end
  end
end
