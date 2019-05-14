# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

## User seeds ##

User.create(
    name: "David Herrera",
    document: "1024564122",
    age: 23,
    sex: "Male",
    email: "dacherreragu@unal.edu.co",
    password: "123456"

)
