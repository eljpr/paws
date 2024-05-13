class CreateVetDogs < ActiveRecord::Migration[7.1]
  def change
    create_table :vet_dogs do |t|
      t.references :user, null: false, foreign_key: true
      t.references :dog, null: false, foreign_key: true

      t.timestamps
    end
  end
end
