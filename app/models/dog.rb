class Dog < ApplicationRecord
  belongs_to :user
  has_many %i[walks logs prescriptions vet_dogs]
  validates :name, :breed, presence: true
end
