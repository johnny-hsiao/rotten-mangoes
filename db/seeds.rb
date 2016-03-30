# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

admin = User.new(
  email: "test@example.com",
  firstname: "admin",
  lastname: "admin",
  password: "password",
  password_confirmation: "password",
  is_admin: true
)
admin.save

50.times do 
  user = User.new(
    email: Faker::Internet.email,
    firstname: Faker::Name.first_name,
    lastname: Faker::Name.last_name,
    password: "password",
    password_confirmation: "password"
  )

  user.save!
end