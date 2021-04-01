# frozen_string_literal: true

class CreateShippingRates < ActiveRecord::Migration[5.2]
  def change
    create_table :shipping_rates do |t|
      t.string :name
      t.decimal :min_order_weight
      t.decimal :max_order_weight
      t.boolean :free_shipping, default: false
      t.string :type

      t.timestamps
    end
  end
end
