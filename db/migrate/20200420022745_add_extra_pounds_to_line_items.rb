class AddExtraPoundsToLineItems < ActiveRecord::Migration[5.2]
  def change
    add_column :line_items, :extra_pounds, :decimal
  end
end
