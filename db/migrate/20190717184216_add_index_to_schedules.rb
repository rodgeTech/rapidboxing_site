# frozen_string_literal: true

class AddIndexToSchedules < ActiveRecord::Migration[5.2]
  def change
    add_index :schedules, :departure, unique: true
    add_index :schedules, :arrival, unique: true
  end
end
