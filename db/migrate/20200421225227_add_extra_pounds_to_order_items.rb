# frozen_string_literal: true

class AddExtraPoundsToOrderItems < ActiveRecord::Migration[5.2]
  def change
    add_column :order_items, :extra_pounds, :decimal
  end
end
