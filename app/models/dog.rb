class Dog < ApplicationRecord
  belongs_to :user
  has_many :walks
  has_many :logs
  has_many :prescriptions
  has_many :vet_dogs
  has_many :vet, through: :vet_dogs, source: :user
  validates :name, :breed, presence: true
end
