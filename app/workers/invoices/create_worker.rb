# frozen_string_literal: true

module Invoices
  class CreateWorker
    include Sidekiq::Worker

    def perform(invoice_id)
      invoice = Invoice.find(invoice_id)
      InvoiceMailer.new_invoice(invoice).deliver
    end
  end
end
