class Prescription < ApplicationRecord
  belongs_to :dog
  belongs_to :user

  validates :medication_name, :start_date, :end_date, :dosage, :time_of_day, :number_of_times_per_day, presence: true

end
