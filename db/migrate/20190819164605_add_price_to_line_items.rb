# frozen_string_literal: true

class AddPriceToLineItems < ActiveRecord::Migration[5.2]
  def change
    add_monetize :line_items, :price
  end
end
