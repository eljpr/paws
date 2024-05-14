class Prescription < ApplicationRecord
  belongs_to :dog
  belongs_to :user

  validates name:, start_date:, end_date:, dosage:, time_of_day:, number_of_times_per_day:, presence: true
  validates :dosage, numericality: { only_integer: true }
  validates :dosage, inclusion: { in: %w[`grams milligrams drops capsules milliliters`],
                                  message: `%<value> is not a valid dose` }
end
