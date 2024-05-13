class CreateDogs < ActiveRecord::Migration[7.1]
  def change
    create_table :dogs do |t|
      t.string :name
      t.string :medication
      t.string :condition
      t.string :breed
      t.references :user, null: false, foreign_key: true
      t.date :date_of_birth
      t.integer :weight

      t.timestamps
    end
  end
end
