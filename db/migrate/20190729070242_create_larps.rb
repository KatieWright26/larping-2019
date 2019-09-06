class CreateLarps < ActiveRecord::Migration[5.1]
  def change
    create_table :larps do |t|
      t.references :user
      t.string :title
      t.string :description
      t.datetime :start_date
      t.timestamps
    end
  end
end
