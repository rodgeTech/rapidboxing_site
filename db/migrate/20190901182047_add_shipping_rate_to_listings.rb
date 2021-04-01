class AddShippingRateToListings < ActiveRecord::Migration[5.2]
  def change
    add_reference :listings, :shipping_rate, foreign_key: true
  end
end
