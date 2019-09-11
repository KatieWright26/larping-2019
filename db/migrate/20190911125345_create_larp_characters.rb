class CreateLarpCharacters < ActiveRecord::Migration[5.1]
  def change
    create_table :characters do |t|
      t.string :name
      t.string :race
      t.string :occupation
      t.references :larp, foreign_key: true
      t.references :user, foreign_key: true
      t.string :description
    end
  end
end
