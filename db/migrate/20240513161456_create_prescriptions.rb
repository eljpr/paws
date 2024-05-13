class CreatePrescriptions < ActiveRecord::Migration[7.1]
  def change
    create_table :prescriptions do |t|
      t.references :dog, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :medication_name
      t.boolean :completed
      t.date :start_date
      t.date :end_date
      t.text :description
      t.integer :dosage
      t.string :time_of_day
      t.integer :number_of_times_per_day

      t.timestamps
    end
  end
end
