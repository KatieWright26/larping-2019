class AddNamesToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :name, :string
    add_reference :users, :larps
  end
end
