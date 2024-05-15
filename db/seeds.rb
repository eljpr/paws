# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
puts "Cleaning database"

Prescription.destroy_all
Walk.destroy_all
VetDog.destroy_all
Dog.destroy_all
User.destroy_all

puts "Creating users..."
# Owners
gilmar = User.create!(first_name: "Gilmar", last_name: "Margoti",  email: "gilmar@gmail.com", password: "123456", is_vet: false)
max = User.create!(first_name: "Max", last_name: "Cody", email: "codym08@gmail.com", password: "123456", is_vet: false)
ella = User.create!(first_name: "Ella", last_name: "Pierre", email: "ella@owner.com", password: "123456", is_vet: false)
robbie = User.create!(first_name: "Robbie", last_name: "Radev", email: "robbie@owner.com", password: "123456", is_vet: false)
elise = User.create!(first_name: "Elise", last_name: "Acher", email: "elise@owner.com", password: "123456", is_vet: false)
sofia = User.create!(first_name: "Sofia", last_name: "Singam", email: "sofia@owner.com", password: "123456", is_vet: false)
# Vets
ife = User.create!(first_name: "Ife", last_name: "Odugbesan", email: "ife@vet.com", password: "123456", is_vet: true)
mo = User.create!(first_name: "Mo", last_name: "Rashid", email: "mo@vet.com", password: "123456", is_vet: true)
raeesa = User.create!(first_name: "Raessa", last_name: "Qureshi", email: "raessa@vet.com", password: "123456", is_vet: true)
meli = User.create!(first_name: "Melissa", last_name: "Murday", email: "meli@vet.com", password: "123456", is_vet: true)
ben = User.create!(first_name: "Ben", last_name: "Tisdall", email: "ben@vet.com", password: "123456", is_vet: true)
puts "Users created successfully..."

puts "Creating dogs"
ruby = Dog.create!(name: "Ruby", medication: "Glucosamine", condition:"None", breed: "Catalan Sheepdog", user_id: max.id, date_of_birth: Date.new(2019, 5, 10), weight: 25)
thalys = Dog.create!(name: "Thalys", medication: "Amitraz", condition:"Demodex", breed: "Belgian Shepherd", user_id: ella.id, date_of_birth: Date.new(2017, 10, 10), weight: 22)
peneloppe = Dog.create!(name: "Peneloppe", medication: "None", condition:"None", breed: "Great Dane", user_id: gilmar.id, date_of_birth: Date.new(2015, 5, 15), weight: 45)
malu = Dog.create!(name: "Malu", medication: "None", condition:"None", breed: "Dachshund", user_id: gilmar.id, date_of_birth: Date.new(2011, 05, 15), weight: 10)
piggy = Dog.create!(name: "Piggy", medication: "None", condition:"None", breed: "Pug", user_id: robbie.id, date_of_birth: Date.new(2013, 06, 13), weight: 7)
lulla = Dog.create!(name: "Lulla", medication: "None", condition:"None", breed: "Cockapoo", user_id: elise.id, date_of_birth: Date.new(2018, 7, 20), weight: 7)
miko = Dog.create!(name: "Miko", medication: "None", condition:"None", breed: "Shiba Inu", user_id: sofia.id, date_of_birth: Date.new(2019, 8, 25), weight: 10)
puts "Dog created successfully..."

puts "Creating vet_dogs"
VetDog.create!(user: meli, dog: thalys)
VetDog.create!(user: meli, dog: peneloppe)
VetDog.create!(user: ben, dog: ruby)
VetDog.create!(user: ife, dog: malu)
VetDog.create!(user: ife, dog: miko)
VetDog.create!(user: raeesa, dog: piggy)
VetDog.create!(user: mo, dog: lulla)
puts"Vet_dog created successfully..."

# Walk.create!(start_time: Time.new(2024, 5, 15, 9, 0, 0), end_time: Time.new(2024, 5, 15, 10, 0, 0), pace: 5.2, start_lat: 40.7128, start_lng: -74.0060, end_lat: 40.7218, end_lng: -73.9977, distance: 2.5, dog: Dog.first)
# puts "creating a prescription"
# Prescription.create!(dog: ruby, user: User.first, medication_name: 'Heartgard', completed: false, start_date: Date.new(2024, 5, 1), end_date: Date.new(2024, 5, 30), description: 'Heartworm prevention medication', dosage: '50mg', time_of_day: 'morning', number_of_times_per_day: 1)
# puts "Prescription created successfully..."
