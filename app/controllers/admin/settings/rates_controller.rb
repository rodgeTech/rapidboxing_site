# frozen_string_literal: true

module Admin
  module Settings
    class RatesController < BaseController
      before_action :get_setting, only: %i[edit update]

      def show; end

      def create
        setting_params.keys.each do |key|
          unless setting_params[key].nil?
            RateSetting.send("#{key}=", setting_params[key].strip)
          end
        end
        redirect_to admin_settings_rates_path,
                    flash: { notice: 'Setting was successfully updated.' }
      end

      private

      def setting_params
        params.require(:setting).permit(:initial_deposit, :tax,
                                        :duty_rate, :service_charge,
                                        :insurance, :initial_deposit,
                                        :exchange_rate, :additional_pounds)
      end
    end
  end
end
