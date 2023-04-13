# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#

User.create!(name: "Todd Edison",
             email: "inthetube@hotmail.com",
             password: "1nth3tub34Z",
             password_confirmation: "1nth3tub34Z",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

User.create!(name: "Alden Edison",
            email: "edisoald000@gmail.com",
            password: "12345678",
            password_confirmation: "12345678",
            admin: false,
            activated: true,
            activated_at: Time.zone.now)

User.create!(name: "Lynn Blackwood",
            email: "lgbjjh@msn.com",
            password: "12345678",
            password_confirmation: "12345678",
            admin: false,
            activated: true,
            activated_at: Time.zone.now)

50.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end

users = User.order(:created_at).take(6)
11.times do
  users.each { |user| user.microposts.create!(course: "Meadow Park", game_date: "9/23/2017", slope: 115, rating: 78.5, score: 82) }
end
