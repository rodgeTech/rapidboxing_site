class CreateSlides < ActiveRecord::Migration[5.2]
  def change
    create_table :slides do |t|
      t.string :main_title
      t.string :sub_title
      t.string :link_to

      t.timestamps
    end
  end
end
