# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
puts 'Seeding...'
User.create(email: 'user1@gmail.com', username: 'user@1', first_name: 'user1', password: '11111111')
User.create(email: 'user2@gmail.com', username: 'user@2', first_name: 'user2', password: '11111111')
User.create(email: 'user3@gmail.com', username: 'user@3', first_name: 'user3', password: '11111111')
User.create(email: 'user4@gmail.com', username: 'user@4', first_name: 'user4', password: '11111111')
puts 'Seeding done.'
