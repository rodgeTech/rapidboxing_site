class AddShippingRateToLineItems < ActiveRecord::Migration[5.2]
  def change
    add_reference :line_items, :shipping_rate, foreign_key: true
  end
end
