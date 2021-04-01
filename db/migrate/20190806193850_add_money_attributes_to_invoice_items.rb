# frozen_string_literal: true

class AddMoneyAttributesToInvoiceItems < ActiveRecord::Migration[5.2]
  def change
    add_monetize :invoice_items, :unit_price
    add_monetize :invoice_items, :total
  end
end
