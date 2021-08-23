# frozen_string_literal: true

module Api
  module V1
    class OrderItemsController < BaseController
      skip_before_action :authenticate_user!
      before_action :order_item, only: [:show, :update]

      def show
        options = {}
        options[:include] = [:images]
        render json: OrderItemSerializer.new(@order_item, options).serialized_json
      end

      def update
        if @order_item.update_attributes(order_item_params)
          render json: { message: 'Order item successfully created' },
                 status: :created
        else
          render json: { errors: @order_item.errors.full_messages },
                 status: :unprocessable_entity
        end
      end

      private

      def order_item_params
        params.permit(:shipping_rate_id, :price, :extra_pounds, :local_pickup)
      end

      def order_item
        @order_item ||= OrderItem.find(params[:id])
      end
    end
  end
end
