# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require "open-uri"



puts "Cleaning database"

Prescription.destroy_all
Walk.destroy_all
VetDog.destroy_all
Dog.destroy_all
User.destroy_all

puts "Creating users..."
# Owners
gilmar = User.create!(first_name: "Gilmar", last_name: "Margoti",  email: "gilmar@gmail.com", password: "123456", is_vet: false, address: "Rua da Alegria, 123", mobile_number: "123456789")
gilmar_pic = URI.open("https://res.cloudinary.com/ddxuxbfmy/image/upload/v1715865274/gilmar_ooc7zo.jpg")
gilmar.photo.attach(io: gilmar_pic, filename: "gilmar.jpg", content_type: "image/jpg")

max = User.create!(first_name: "Max", last_name: "Cody", email: "codym08@gmail.com", password: "123456", is_vet: false, address: "Great Portland Street, 392", mobile_number: "293010394")
max_pic = URI.open("https://res.cloudinary.com/ddxuxbfmy/image/upload/v1715865273/max_pzxuoc.jpg")
max.photo.attach(io: max_pic, filename: "max.jpg", content_type: "image/jpg")

ella = User.create!(first_name: "Ella", last_name: "Pierre", email: "ella@owner.com", password: "123456", is_vet: false, address: "Baker Street, 221B", mobile_number: "49449109103")
ella_pic = URI.open("https://res.cloudinary.com/ddxuxbfmy/image/upload/v1715867864/ella_wu1qyd.jpg")
ella.photo.attach(io: ella_pic, filename: "ella.jpg", content_type: "image/jpg")

robbie = User.create!(first_name: "Robbie", last_name: "Radev", email: "robbie@owner.com", password: "123456", is_vet: false, address: "Bond Street, 221B", mobile_number: "233928405")
robbie_pic = URI.open("https://res.cloudinary.com/ddxuxbfmy/image/upload/v1715865275/robbie_tuinzk.png")
robbie.photo.attach(io: robbie_pic, filename: "robbie.jpg", content_type: "image/jpg")

elise = User.create!(first_name: "Elise", last_name: "Acher", email: "elise@owner.com", password: "123456", is_vet: false, address: "Oxford Street, 221B", mobile_number: "693849302")
elise_pic = URI.open("https://res.cloudinary.com/ddxuxbfmy/image/upload/v1715865273/elise_dw0yj2.jpg")
elise.photo.attach(io: elise_pic, filename: "elise.jpg", content_type: "image/jpg")

sofia = User.create!(first_name: "Sofia", last_name: "Singam", email: "sofia@owner.com", password: "123456", is_vet: false, address: "Regent Street, 221B", mobile_number: "950292842")
sofia_pic = URI.open("https://res.cloudinary.com/ddxuxbfmy/image/upload/v1715865275/sofia_oq99yv.jpg")
sofia.photo.attach(io: sofia_pic, filename: "sofia.jpg", content_type: "image/jpg")

# Vets
ife = User.create!(first_name: "Ife", last_name: "Odugbesan", email: "ife@vet.com", password: "123456", is_vet: true, address: "Wimpole Street", mobile_number: "902840502", opening_time: Time.new(2024, 5, 15, 9, 0, 0), closing_time: Time.new(2024, 5, 15, 18, 0, 0))
ife_pic = URI.open("https://res.cloudinary.com/ddxuxbfmy/image/upload/v1715865274/ife_ul1vki.png")
ife.photo.attach(io: ife_pic, filename: "ife.jpg", content_type: "image/jpg")

mo = User.create!(first_name: "Mo", last_name: "Rashid", email: "mo@vet.com", password: "123456", is_vet: true, address: "Harley Street", mobile_number: "749204910", opening_time: Time.new(2024, 5, 15, 9, 0, 0), closing_time: Time.new(2024, 5, 15, 18, 0, 0))
mo_pic = URI.open("https://res.cloudinary.com/ddxuxbfmy/image/upload/v1715865274/mo_j8egri.jpg")
mo.photo.attach(io: mo_pic, filename: "mo.jpg", content_type: "image/jpg")

raeesa = User.create!(first_name: "Raessa", last_name: "Qureshi", email: "raessa@vet.com", password: "123456", is_vet: true, address: "Marylebone High Street", mobile_number: "293840502", opening_time: Time.new(2024, 5, 15, 9, 0, 0), closing_time: Time.new(2024, 5, 15, 18, 0, 0))
raeesa_pic = URI.open("https://res.cloudinary.com/ddxuxbfmy/image/upload/v1715865274/raeesa_j8sgng.jpg")
raeesa.photo.attach(io: raeesa_pic, filename: "raessa.jpg", content_type: "image/jpg")

meli = User.create!(first_name: "Melissa", last_name: "Murday", email: "meli@vet.com", password: "123456", is_vet: true, address: "Berwick Street", mobile_number: "940294901", opening_time: Time.new(2024, 5, 15, 9, 0, 0), closing_time: Time.new(2024, 5, 15, 18, 0, 0))
meli_pic = URI.open("https://res.cloudinary.com/ddxuxbfmy/image/upload/v1715865273/meli_jvwngi.jpg")
meli.photo.attach(io: meli_pic, filename: "meli.jpg", content_type: "image/jpg")

ben = User.create!(first_name: "Ben", last_name: "Tisdall", email: "ben@vet.com", password: "123456", is_vet: true, address: "Carnaby Street", mobile_number: "839402940", opening_time: Time.new(2024, 5, 15, 9, 0, 0), closing_time: Time.new(2024, 5, 15, 18, 0, 0))
ben_pic = URI.open("https://res.cloudinary.com/ddxuxbfmy/image/upload/v1715868092/ben_wcjdeo.jpg")
ben.photo.attach(io: ben_pic, filename: "ben.jpg", content_type: "image/jpg")

puts "Users created successfully..."

puts "Creating dogs"
ruby = Dog.create!(name: "Ruby", medication: "Glucosamine", condition:"None", breed: "Catalan Sheepdog", user_id: max.id, date_of_birth: Date.new(2019, 5, 10), weight: 25)
ruby_pic = URI.open("https://res.cloudinary.com/ddxuxbfmy/image/upload/v1715868357/ruby_uloemu.jpg")
ruby.photo.attach(io: ruby_pic, filename: "ruby.jpg", content_type: "image/jpg")

thalys = Dog.create!(name: "Thalys", medication: "Amitraz", condition:"Demodex", breed: "Belgian Shepherd", user_id: ella.id, date_of_birth: Date.new(2017, 10, 10), weight: 22)
thalys_pic = URI.open("https://res.cloudinary.com/ddxuxbfmy/image/upload/v1715867300/thalys_cyzlju.jpg")
thalys.photo.attach(io: thalys_pic, filename: "thalys.jpg", content_type: "image/jpg")

peneloppe = Dog.create!(name: "Peneloppe", medication: "None", condition:"None", breed: "Great Dane", user_id: gilmar.id, date_of_birth: Date.new(2015, 5, 15), weight: 45)
peneloppe_pic = URI.open("https://res.cloudinary.com/ddxuxbfmy/image/upload/v1715865275/peneloppe_vi9xf1.jpg")
peneloppe.photo.attach(io: peneloppe_pic, filename: "peneloppe.jpg", content_type: "image/jpg")

poker = Dog.create!(name: "Poker", medication: "None", condition:"None", breed: "Pomeranian", user_id: gilmar.id, date_of_birth: Date.new(2011, 05, 15), weight: 10)
poker_pic = URI.open("https://res.cloudinary.com/ddxuxbfmy/image/upload/v1715868763/poker_bxorzz.jpg")
poker.photo.attach(io: poker_pic, filename: "poker.jpg", content_type: "image/jpg")

piggy = Dog.create!(name: "Piggy", medication: "None", condition:"None", breed: "Dachshund", user_id: robbie.id, date_of_birth: Date.new(2013, 06, 13), weight: 7)
piggy_pic = URI.open("https://res.cloudinary.com/ddxuxbfmy/image/upload/v1715865274/piggy_sawiqs.webp")
piggy.photo.attach(io: piggy_pic, filename: "piggy.jpg", content_type: "image/jpg")

lulla = Dog.create!(name: "Lulla", medication: "None", condition:"None", breed: "Cockapoo", user_id: elise.id, date_of_birth: Date.new(2018, 7, 20), weight: 7)
lulla_pic = URI.open("https://res.cloudinary.com/ddxuxbfmy/image/upload/v1715865274/lulla_hqmnyn.avif")
lulla.photo.attach(io: lulla_pic, filename: "lulla.jpg", content_type: "image/jpg")

miko = Dog.create!(name: "Miko", medication: "None", condition:"None", breed: "Shiba Inu", user_id: sofia.id, date_of_birth: Date.new(2019, 8, 25), weight: 10)
miko_pic = URI.open("https://res.cloudinary.com/ddxuxbfmy/image/upload/v1715865273/miko_iymfty.avif")
miko.photo.attach(io: miko_pic, filename: "miko.jpg", content_type: "image/jpg")
puts "Dog created successfully..."

puts "Creating vet_dogs"
VetDog.create!(user: meli, dog: thalys)
VetDog.create!(user: meli, dog: peneloppe)
VetDog.create!(user: meli, dog: poker)
VetDog.create!(user: ben, dog: ruby)
VetDog.create!(user: ife, dog: miko)
VetDog.create!(user: raeesa, dog: piggy)
VetDog.create!(user: mo, dog: lulla)
puts"Vet_dog created successfully..."

puts "Creating prescriptions"
Prescription.create!(dog: thalys, user: ella, medication_name: "NSAID", completed: false, start_date: Date.new(2024, 5, 1), end_date: Date.new(2024, 5, 30), description: "Joint health supplement", dosage: "50mg", time_of_day: "morning", number_of_times_per_day: 1)
puts "Prescription created successfully..."

# Walk.create!(start_time: Time.new(2024, 5, 15, 9, 0, 0), end_time: Time.new(2024, 5, 15, 10, 0, 0), pace: 5.2, start_lat: 40.7128, start_lng: -74.0060, end_lat: 40.7218, end_lng: -73.9977, distance: 2.5, dog: Dog.first)
# puts "creating a prescription"
# Prescription.create!(dog: ruby, user: User.first, medication_name: 'Heartgard', completed: false, start_date: Date.new(2024, 5, 1), end_date: Date.new(2024, 5, 30), description: 'Heartworm prevention medication', dosage: '50mg', time_of_day: 'morning', number_of_times_per_day: 1)
# puts "Prescription created successfully..."
