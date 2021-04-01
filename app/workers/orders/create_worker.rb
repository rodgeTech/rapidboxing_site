# frozen_string_literal: true

module Orders
  class CreateWorker
    include Sidekiq::Worker

    def perform(order_id)
      order = Order.find(order_id)
      OrderMailer.new_order(order).deliver
    end
  end
end
