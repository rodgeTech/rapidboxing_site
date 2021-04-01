# frozen_string_literal: true

module Admin
  module Settings
    class PriceShippingRatesController < BaseController
      before_action :price_shipping_rate, only: %i[edit update destroy]

      def new
        @price_shipping_rate = PriceShippingRate.new
      end

      def create
        @price_shipping_rate = PriceShippingRate.new(price_shipping_rate_params)
        if @price_shipping_rate.save
          redirect_to admin_settings_shipping_path,
                      flash: { success: 'Shipping rate created successfully' }
        else
          render :new
        end
      end

      def edit; end

      def update
        if @price_shipping_rate.update_attributes(price_shipping_rate_params)
          redirect_to admin_settings_shipping_path,
                      flash: { success: 'Shipping rate updated successfully' }
        else
          render :edit
        end
      end

      def destroy
        @price_shipping_rate.destroy
        redirect_to admin_settings_shipping_path,
                    flash: { success: 'Shipping rate removed successfully' }
      end

      private

      def price_shipping_rate_params
        params.require(:price_shipping_rate).permit(:name, :min_order_price,
                                                    :max_order_price,
                                                    :free_shipping,
                                                    :rate_amount)
      end

      def price_shipping_rate
        @price_shipping_rate ||= PriceShippingRate.find(params[:id])
      end
    end
  end
end
