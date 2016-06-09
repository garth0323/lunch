require 'faker'


namespace :db do 
  desc "Fill database with sample data"
  task :populate => :environment do
    10.times do |n|
      name =  Faker::Hipster.word 
      phone = Faker::PhoneNumber.cell_phone
      description =  Faker::Hipster.paragraph
      Restaurant.where(name: name, 
                   description: description,
                   phone: phone).first_or_create
    end
    3.times do |n|
      username = Faker::Name.first_name
      email = Faker::Internet.email
      User.create(username: username,
                  email: email,
                  password: 'password',
                  password_confirmation: 'password')
    end
    5.times do |n|
      Review.where(user: User.order("RANDOM()").first, 
                    restaurant: Restaurant.order("RANDOM()").first, 
                    content: Faker::Hipster.sentence).first_or_create
    end
  end 
end 
