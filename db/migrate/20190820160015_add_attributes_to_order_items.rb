# frozen_string_literal: true

class AddAttributesToOrderItems < ActiveRecord::Migration[5.2]
  def change
    add_monetize :order_items, :price
    add_reference :order_items, :shipping_rate, foreign_key: true
  end
end
