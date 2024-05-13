class AddIsVetToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :is_vet, :boolean
  end
end
