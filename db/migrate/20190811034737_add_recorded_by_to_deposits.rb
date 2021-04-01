# frozen_string_literal: true

class AddRecordedByToDeposits < ActiveRecord::Migration[5.2]
  def change
    add_reference :deposits, :recorded_by, foreign_key: { to_table: :users }
  end
end
