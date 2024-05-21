class AddPathToWalks < ActiveRecord::Migration[7.1]
  def change
    add_column :walks, :path, :json
  end
end
