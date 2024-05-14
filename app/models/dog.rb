class Dog < ApplicationRecord
  belongs_to :user
  has_many :walks
  has_many :logs
  has_many :prescriptions
  has_many :vet_dogs
  validates :name, :breed, presence: true
end
