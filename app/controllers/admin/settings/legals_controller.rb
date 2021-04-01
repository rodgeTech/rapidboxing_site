# frozen_string_literal: true

module Admin
  module Settings
    class LegalsController < BaseController
      before_action :get_setting, only: %i[edit update]

      def show; end

      def create
        setting_params.keys.each do |key|
          LegalSetting.send("#{key}=", setting_params[key].strip) unless setting_params[key].nil?
        end
        redirect_to admin_settings_legal_path,
                    flash: { notice: 'Setting was successfully updated.' }
      end

      private

      def setting_params
        params.require(:setting).permit(:refund_policy, :shipping_policy,
                                        :delivery_policy, :privacy_policy,
                                        :terms_of_service)
      end
    end
  end
end
