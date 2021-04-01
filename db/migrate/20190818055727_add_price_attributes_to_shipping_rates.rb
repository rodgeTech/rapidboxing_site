# frozen_string_literal: true

class AddPriceAttributesToShippingRates < ActiveRecord::Migration[5.2]
  def change
    add_monetize :shipping_rates, :min_order_price
    add_monetize :shipping_rates, :max_order_price
    add_monetize :shipping_rates, :rate_amount
  end
end
