# frozen_string_literal: true

module Api
  module V1
    class InvoicesController < BaseController
      skip_before_action :authenticate_user!

      def create
        result = Invoices::CreateService.call(order: @order)
        if result.success?
          # Invoices::CreateWorker.perform_async(invoice.id)
          InvoicesJob.perform_async(result.record.id)

          render json: InvoiceSerializer.new(invoice).serialized_json
        else
          render json: { errors: result.record.errors.full_messages },
                 status: :unprocessable_entity
        end
      end
    end
  end
end
