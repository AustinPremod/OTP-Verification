# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
5.times do
    Usernumber.create({
        phone: Faker::Number.number(digits: 10),
        otp: 4.times.map{rand(9)}.join,
        counter:1,
        otpcounter:1
    })
end
