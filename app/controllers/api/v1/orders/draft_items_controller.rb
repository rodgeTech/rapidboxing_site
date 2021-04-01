# frozen_string_literal: true

module Api
  module V1
    module Orders
      class DraftItemsController < BaseController
        def index
          options = {}
          options[:include] = %i[shipping_rate]
          draft_items = Order.find(params[:draft_id]).order_items.order(created_at: :desc)
          render json: OrderItemSerializer.new(draft_items, options).serialized_json
        end

        def create
          order_item = OrderItem.new(order_item_params)
          if order_item.save
            render json: { message: 'Draft order item successfully created' },
                   status: :created

          else
            render json: { errors: order_item.errors.full_messages },
                   status: :unprocessable_entity
          end
        end

        private

        def order_item_params
          params.permit(:details, :quantity, :link, :shipping_rate_id,
                        :price, :listing_id, :order_id)
        end
      end
    end
  end
end
