# frozen_string_literal: true

class DeviseTokenAuthUpdateUsers < ActiveRecord::Migration[5.2]
  def change
    change_table(:users) do |t|
      ## Required
      t.string :provider, null: false, default: 'email'
      t.string :uid, null: false, default: ''

      ## Recoverable
      t.boolean :allow_password_change, default: true

      ## Tokens
      t.json :tokens
    end

    User.reset_column_information

    User.find_each do |u|
      u.name = u.name.nil? ? u.email.split('@')[0] : u.name
      u.uid = u.email
      u.provider = 'email'
      u.save!
    end

    add_index :users, %i[uid provider], unique: true
  end
end
