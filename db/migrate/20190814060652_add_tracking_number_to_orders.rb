# frozen_string_literal: true

class AddTrackingNumberToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :tracking_number, :integer
    add_index  :orders, :tracking_number
  end
end
