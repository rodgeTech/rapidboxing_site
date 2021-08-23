# frozen_string_literal: true

module Api
  module V1
    class CartsController < BaseController
      include CurrentCart
      before_action :set_current_user_cart

      def show
        options = {}
        options[:include] = [:line_items, 'line_items.images']
        options[:is_collection] = false
        render json: CartSerializer.new(@cart, options).serialized_json
      end
    end
  end
end
