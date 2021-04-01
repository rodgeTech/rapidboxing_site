# frozen_string_literal: true

module Admin
  module Settings
    class WeightShippingRatesController < BaseController
      before_action :weight_shipping_rate, only: %i[edit update destroy]

      def new
        @weight_shipping_rate = WeightShippingRate.new
      end

      def create
        @weight_shipping_rate = WeightShippingRate.new(weight_shipping_rate_params)
        if @weight_shipping_rate.save
          redirect_to admin_settings_shipping_path,
                      flash: { success: 'Shipping rate created successfully' }
        else
          render :new
        end
      end

      def edit; end

      def update
        if @weight_shipping_rate.update_attributes(weight_shipping_rate_params)
          redirect_to admin_settings_shipping_path,
                      flash: { success: 'Shipping rate updated successfully' }
        else
          render :edit
        end
      end

      def destroy
        @weight_shipping_rate.destroy
        redirect_to admin_settings_shipping_path,
                    flash: { success: 'Shipping rate removed successfully' }
      end

      private

      def weight_shipping_rate_params
        params.require(:weight_shipping_rate).permit(:name, :min_order_weight,
                                                     :max_order_weight,
                                                     :free_shipping,
                                                     :rate_amount)
      end

      def weight_shipping_rate
        @weight_shipping_rate ||= WeightShippingRate.find(params[:id])
      end
    end
  end
end
