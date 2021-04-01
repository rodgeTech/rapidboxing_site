# frozen_string_literal: true

module Api
  module V1
    class DepositsController < BaseController
      skip_before_action :authenticate_user!
      before_action :deposit, only: :destroy

      def create
        deposit = Deposit.new(deposit_params)
        deposit.recorded_by = current_user
        if deposit.save
          deposit.order.confirmed! if deposit.order.pending?

          # Receipts::CreateWorker.perform_async(deposit.id)
          ReceiptsJob.perform_async(deposit.id)

          options = {}
          options[:include] = %i[recorded_by]
          render json: DepositSerializer.new(deposit, options).serialized_json
        else
          render json: { errors: deposit.errors.full_messages },
                 status: :unprocessable_entity
        end
      end

      def destroy
        @deposit.destroy
        head :no_content
      end

      private

      def deposit_params
        params.permit(:order_id, :amount)
      end

      def deposit
        @deposit ||= Deposit.find(params[:id])
      end
    end
  end
end
