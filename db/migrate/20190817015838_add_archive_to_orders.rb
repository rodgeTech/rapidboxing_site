# frozen_string_literal: true

class AddArchiveToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :archive, :boolean, default: false
  end
end
