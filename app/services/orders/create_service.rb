# frozen_string_literal: true

module Orders
  class CreateService < BaseService
    def initialize(cart:, current_user:, params:)
      @cart = cart
      @current_user = current_user
      @params = params
    end

    def call
      create_order
    end

    def create_order
      order = Order.new(@params)
      order.user = @current_user if @current_user && !@current_user.admin?
      order.schedule = Schedule.upcoming.first if Schedule.upcoming.any?
      if order.save
        @cart.line_items.each do |line_item|
          order_item = order.order_items.create(link: line_item.link,
                                   details: line_item.details,
                                   quantity: line_item.quantity,
                                   price: line_item.price,
                                   shipping_rate: line_item.shipping_rate,
                                   extra_pounds: line_item.extra_pounds,
                                   local_pickup: line_item.local_pickup)
          
          if line_item.images.any?
            line_item.images.each do |line_item_image|
              order_item.images.create(image: line_item_image.image)
            end
          end
        end
        @cart.destroy
        Result.new(record: order, success: true)
      else
        Result.new(record: order, success: false)
      end
    end
  end
end
