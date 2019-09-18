class AddPublishedFieldToCharacters < ActiveRecord::Migration[5.1]
  def change
    add_column :characters, :published, :boolean, default: false
  end
end
