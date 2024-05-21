class AddColumnToVetDogs < ActiveRecord::Migration[7.1]
  def change
    add_column :vet_dogs, :status, :string, default: "pending"
  end
end
