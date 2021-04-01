# frozen_string_literal: true

module Admin
  module Settings
    class BankingsController < BaseController
      def show; end

      def create
        setting_params.keys.each do |key|
          unless setting_params[key].nil?
            BankSetting.send("#{key}=", setting_params[key].strip)
          end
        end
        redirect_to admin_settings_banking_path,
                    flash: { notice: 'Setting was successfully updated.' }
      end

      private

      def setting_params
        params.require(:setting).permit(:belize_bank, :atlantic_bank,
                                        :scotia_bank, :heritage_bank,
                                        :belize_bank_account_name,
                                        :atlantic_bank_account_name,
                                        :scotia_bank_account_name,
                                        :heritage_bank_account_name)
      end
    end
  end
end
