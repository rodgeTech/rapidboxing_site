# frozen_string_literal: true

class CreateLineItems < ActiveRecord::Migration[5.2]
  def change
    create_table :line_items do |t|
      t.references :listing, foreign_key: true
      t.references :cart, foreign_key: true
      t.boolean :is_listing, default: false
      t.text :link
      t.text :details
      t.integer :quantity, default: 1

      t.timestamps
    end
  end
end
