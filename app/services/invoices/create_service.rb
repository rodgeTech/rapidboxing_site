# frozen_string_literal: true

module Invoices
  class CreateService < BaseService
    def initialize(order:)
      @order = order
    end

    def call
      create_invoice
    end

    def create_invoice
      invoice = Invoice.new(order_id: @order.id, user_id: @order.user_id)
      if invoice.save
        @order.order_items.each do |order_item|
          InvoiceItem.create(
            invoice_id: invoice.id,
            order_item_id: order_item.id
          )
        end
        Result.new(record: invoice, success: true)
      else
        Result.new(record: invoice, success: false)
      end
    end
  end
end
