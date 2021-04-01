class CreateSchedules < ActiveRecord::Migration[5.2]
  def change
    create_table :schedules do |t|
      t.date :departure
      t.date :arrival

      t.timestamps
    end
  end
end
