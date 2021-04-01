# frozen_string_literal: true

module Statuses
  class UpdateWorker
    include Sidekiq::Worker

    def perform(order_id)
      order = Order.find(order_id)
      StatusUpdateMailer.status_updated(order).deliver
    end
  end
end
