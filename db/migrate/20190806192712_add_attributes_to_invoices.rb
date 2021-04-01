# frozen_string_literal: true

class AddAttributesToInvoices < ActiveRecord::Migration[5.2]
  def change
    add_monetize :invoices, :sub_total
    add_monetize :invoices, :shipping_fee
    add_monetize :invoices, :delivery_fee
    add_monetize :invoices, :service_charge
    add_monetize :invoices, :sales_tax
    add_monetize :invoices, :discount
    add_monetize :invoices, :balance
  end
end
