require 'faker'


namespace :db do 
  desc "Fill database with sample data"
  task :populate => :environment do
    10.times do |n|
      name =  Faker::Hipster.word 
      address =  Faker::Address.street_address 
      city = Faker::Address.city_suffix 
      zip  = Faker::Address.zip_code
      state = Faker::Address.state
      phone = Faker::PhoneNumber.cell_phone
      description =  Faker::Hipster.paragraph
      Restaurant.create!(name: name, 
                   description: description,
                   city: city,
                   state: state,
                   address: address,
                   zip: zip,
                   phone: phone)
    end
    3.times do |n|
      username = Faker::Superhero.name
      email = Faker::Internet.email
      User.create(username: username,
                  email: email,
                  password: 'password',
                  password_confirmation: 'password')
    end
    5.times do |n|
      Review.create(user: User.first, restaurant: Restaurant.first, content: Faker::Hipster.sentence)
    end
  end 
end 

# def make_restaurants
#    10.times do |n|
#     name =  Faker::Hipster.word 
#     address =  Faker::Address.street_address 
#     city = Faker::AddressUS.city_suffix 
#     zip  = Faker::AddressUS.zip_code
#     state = Faker::AddressUS.state
#     phone = Faker::PhoneNumber.cell_phone
#     description =  Faker::Hipster.paragraph
#     Restaurant.create!(name: name, 
#                  description: description,
#                  city: city,
#                  state: state,
#                  address: address,
#                  zip: zip,
#                  phone: phone) 
#    end 
# end 

# def make_employees
#    Account.create!(name: "Danny stanzia",
#                 email: "stanza@example.com",
#                 type: "Employee"
#                 )
#    45.times do |n|
#     name =  Faker::Name.name 
#     email =  Faker::Internet.email 
#     city = Faker::AddressUS.city_suffix 
#     state = Faker::AddressUS.state
#     zipcode  = Faker::AddressUS.zip_code
#     type = 'Employee'
#     Account.create!(name: name, 
#                  email: email,
#                  type: type, 
#                  state: state,
#                  city: city,
#                  zipcode: zipcode)
#    end 