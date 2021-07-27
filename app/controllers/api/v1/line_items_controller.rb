# frozen_string_literal: true

module Api
  module V1
    class LineItemsController < BaseController
      include CurrentCart

      # skip_before_action :authenticate_user!
      before_action :set_current_user_cart
      before_action :line_item, only: [:show, :update, :destroy]

      def index
        options = {}
        options[:meta] = { estimated_total: @cart.estimation? ? @cart.estimated_total : 0.0,
                           estimation: @cart.estimation? }
        line_items = @cart.line_items.order(created_at: :desc)
        render json: LineItemSerializer.new(line_items, options).serialized_json
      end

      def show
        options = {}
        options[:include] = [:images]
        # options[:is_collection] = false
        render json: LineItemSerializer.new(@line_item, options).serialized_json
      end

      def create
        result = LineItems::CreateService.call(
          cart: @cart,
          params: line_item_params,
          images: params[:images]
        )
        if result.success?
          render json: { message: 'Line item successfully created' },
                 status: :created

        else
          render json: { errors: result.record.errors.full_messages },
                 status: :unprocessable_entity

        end
      end

      def update
        if @line_item.update_attributes(line_item_params)
          update_images
          render json: { message: 'Line item successfully updated' },
                 status: :ok
        else
          render json: { errors: @line_item.errors.full_messages },
                 status: :unprocessable_entity
        end
      end

      def destroy
        @line_item.destroy
        render json: CartSerializer.new(@cart).serialized_json
      end

      private

      def line_item_params
        params.permit(:details, :quantity, :link, :shipping_rate_id,
                      :price, :listing_id, :extra_pounds, :local_pickup)
      end

      def line_item
        @line_item ||= LineItem.find(params[:id])
      end

      def update_images
        @line_item.images.destroy_all
        if params[:images]
          params[:images].each do |image|
            @line_item.images.create!(image: image)
          end
        end
      end
    end
  end
end
