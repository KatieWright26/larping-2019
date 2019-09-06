class CreateAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :addresses do |t|
      t.string :suburb
      t.string :country
      t.string :street
      t.string :postcode
      t.references :larp

      t.timestamps
    end
  end
end
