class CreateWalks < ActiveRecord::Migration[7.1]
  def change
    create_table :walks do |t|
      t.time :start_time
      t.time :end_time
      t.float :pace
      t.decimal :start_lat
      t.decimal :start_lng
      t.decimal :end_lat
      t.decimal :end_lng
      t.float :distance
      t.references :dog, null: false, foreign_key: true

      t.timestamps
    end
  end
end
