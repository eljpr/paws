# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
puts "cleaning database"

Dog.destroy_all
User.destroy_all
Walk.destroy_all

puts "Creating users..."
gilmar = User.create!(first_name: "Gilmar", last_name: "Margoti",  email: "gilmar@gmail.com",      password: "123456", is_vet: false)
ella   = User.create!(first_name: "Ella",   last_name: "Pierri",   email: "ellajpierre@gmail.com", password: "123456", is_vet: false)
max    = User.create!(first_name: "Max",    last_name: "Cody",     email: "codym08@gmail.com",     password: "123456", is_vet: false)
puts "Users created successfully..."


#dogs
puts "creating a dog"

Dog.create!(name: "ruby", medication: "glucosamine", condition:"fine", breed: "catalan sheepdog", user: max, date_of_birth: Date.new(2019, 5, 10), weight: 25)
# Walk.create!(start_time: Time.new(2024, 5, 15, 9, 0, 0), end_time: Time.new(2024, 5, 15, 10, 0, 0), pace: 5.2, start_lat: 40.7128, start_lng: -74.0060, end_lat: 40.7218, end_lng: -73.9977, distance: 2.5, dog: Dog.first)
Prescription.create!(dog: Dog.first, user: User.first, medication_name: 'Heartgard', completed: false, start_date: Date.new(2024, 5, 1), end_date: Date.new(2024, 5, 30), description: 'Heartworm prevention medication', dosage: 50, time_of_day: 'morning', number_of_times_per_day: 1)
