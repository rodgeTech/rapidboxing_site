# frozen_string_literal: true

class AddLocalPickupToOrderItems < ActiveRecord::Migration[5.2]
  def change
    add_column :order_items, :local_pickup, :boolean, default: false
  end
end
