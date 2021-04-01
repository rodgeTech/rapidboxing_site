# frozen_string_literal: true

class AddDraftToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :draft, :boolean, default: false
  end
end
