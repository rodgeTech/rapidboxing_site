# frozen_string_literal: true

module Admin
  module Settings
    class GeneralsController < BaseController
      before_action :get_setting, only: %i[edit update]

      def show; end

      def create
        setting_params.keys.each do |key|
          GeneralSetting.send("#{key}=", setting_params[key].strip) unless setting_params[key].nil?
        end
        redirect_to admin_settings_general_path,
                    flash: { notice: 'Setting was successfully updated.' }
      end

      private

      def setting_params
        params.require(:setting).permit(:business_name, :contact_email,
                                        :contact_email, :phone, :street, :city)
      end
    end
  end
end
