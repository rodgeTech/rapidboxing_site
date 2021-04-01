# frozen_string_literal: true

class CreateImages < ActiveRecord::Migration[5.2]
  def change
    create_table :images do |t|
      t.string :image
      t.integer :imageable_id
      t.string :imageable_type

      t.timestamps
    end
  end
end
