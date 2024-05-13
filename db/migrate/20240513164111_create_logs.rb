class CreateLogs < ActiveRecord::Migration[7.1]
  def change
    create_table :logs do |t|
      t.string :food
      t.string :medication
      t.string :special_treat
      t.string :grooming
      t.string :stool
      t.string :vaccination
      t.references :dog, null: false, foreign_key: true
      t.string :mood
      t.string :energy
      t.string :training

      t.timestamps
    end
  end
end
