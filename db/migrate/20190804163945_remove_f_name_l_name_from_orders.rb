# frozen_string_literal: true

class RemoveFNameLNameFromOrders < ActiveRecord::Migration[5.2]
  def change
    remove_column :orders, :first_name, :string
    remove_column :orders, :last_name, :string
  end
end
