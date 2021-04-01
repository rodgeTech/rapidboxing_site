class AddRequirementsToListings < ActiveRecord::Migration[5.2]
  def change
    add_column :listings, :requirements, :text
  end
end
