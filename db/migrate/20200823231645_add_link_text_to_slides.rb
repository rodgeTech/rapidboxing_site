class AddLinkTextToSlides < ActiveRecord::Migration[5.2]
  def change
    add_column :slides, :link_text, :string
  end
end
