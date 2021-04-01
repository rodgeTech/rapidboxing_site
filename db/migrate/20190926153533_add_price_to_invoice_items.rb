# frozen_string_literal: true

class AddPriceToInvoiceItems < ActiveRecord::Migration[5.2]
  def change
    add_monetize :invoice_items, :price
  end
end
