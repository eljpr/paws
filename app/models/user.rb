class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :dogs, :vet_dogs, :prescriptions, :chats
  # has_many :walks, through: :dogs
  # has_many :logs, through: :dogs

  validates :is_vet, presence: true
  validates :opening_time, :closing_time, presence: true, time: true, allow_blank: true if is_vet
end
