# frozen_string_literal: true

module Api
  module V1
    class OrdersController < BaseController
      include CurrentCart
      skip_before_action :authenticate_user!, only: :track_order
      before_action :set_current_user_cart, only: :create
      before_action :order, only: %i[show status_update email_invoice archive]
      before_action :invoice, only: :email_invoice

      def index
        @orders = current_user.orders.order(created_at: :desc)

        render json: OrderSerializer.new(@orders).serialized_json
      end

      def show
        options = {}
        options[:meta] = {
          price_shipping_rates: PriceShippingRateSerializer.new(PriceShippingRate.order(created_at: :desc)),
          weight_shipping_rates: WeightShippingRateSerializer.new(WeightShippingRate.order(created_at: :desc)),
          total: @order.total,
          balance: @order.balance
        }
        options[:include] = %i[order_items invoice deposits
                               deposits.recorded_by
                               order_items.shipping_rate]
        render json: OrderSerializer.new(@order, options).serialized_json
      end

      def create
        result = ::Orders::CreateService.call(
          cart: @cart,
          current_user: current_user,
          params: order_params
        )
        if result.success?
          OrdersJob.perform_async(result.record.id)
          # ::Orders::CreateWorker.perform_async(result.record.id)

          render json: { message: 'Order successfully created' },
                 status: :created

        else
          render json: { errors: result.record.errors.full_messages },
                 status: :unprocessable_entity

        end
      end

      def archive
        @order.update_attributes(archive: true)
        render json: { message: 'Order archived ' },
               status: :ok
      end

      def status_update
        if @order.update_attributes(order_params)
          StatusesJob.perform_async(order.id)
          # Statuses::UpdateWorker.perform_async(order.id)
          if @order.user.present?
            NotificationsJob.perform_async(@order.status, @order.user_id)
            # Notifications::CreateWorker.perform_async(@order.status,
            #                                           @order.user_id)
          end

          render json: { message: 'Order status updated ' },
                 status: :ok
        else
          render json: { errors: @order.errors.full_messages },
                 status: :unprocessable_entity
        end
      end

      def track_order
        order = Order.find_by_tracking_number(params[:id])
        if order.present?
          render json: OrderSerializer.new(order).serialized_json
        else
          render json: { error: 'No order found for that tracking number' },
                 status: :not_found
        end
      end

      def email_invoice
        @order.update_attributes(invoice_emailed_at: Time.now)

        # Invoices::CreateWorker.perform_async(@invoice.id)
        InvoicesJob.perform_async(@invoice.id)

        head :ok
      end

      private

      def order_params
        params.permit(:id, :email, :contact_number, :name, :address, :status)
      end

      def order
        @order ||= Order.find(params[:id])
      end

      def invoice
        unless @order.invoice.present?
          Invoices::CreateService.call(order: @order)
          @order.reload_invoice
        end
        @invoice = @order.invoice
      end
    end
  end
end
