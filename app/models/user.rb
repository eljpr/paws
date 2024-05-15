class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :dogs
  has_many :vet_dogs
  has_many :prescriptions
  has_many :chats
  # has_many :walks, through: :dogs
  # has_many :logs, through: :dogs

  # validates :is_vet, presence: true
  # validates :opening_time, :closing_time, presence: true if ?? (after create validation or javascript validation?)
end
