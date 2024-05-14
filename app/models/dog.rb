class Dog < ApplicationRecord
  belongs_to :user
  has_many :walks, :logs, :prescriptions, :vet_dogs
  validates :name, :breed, presence: true
end
