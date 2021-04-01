# frozen_string_literal: true

class AddLocalPickupToLineItems < ActiveRecord::Migration[5.2]
  def change
    add_column :line_items, :local_pickup, :boolean, default: false
  end
end
