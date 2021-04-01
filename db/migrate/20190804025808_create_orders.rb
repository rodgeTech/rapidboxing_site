class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.references :user, foreign_key: true
      t.string :first_name
      t.string :last_name
      t.string :contact_number
      t.string :email
      t.string :address

      t.timestamps
    end
  end
end
