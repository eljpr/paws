class ChangeDosageInPrescriptions < ActiveRecord::Migration[7.1]
  def change
    change_column :prescriptions, :dosage, :string
  end
end
