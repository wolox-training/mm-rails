# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

[*1..50_000].each do
  book = Book.create(author: Faker::Book.author, title: Faker::Book.title.first(25),
                     publisher: Faker::Book.publisher, year: Faker::Number.positive.truncate.to_s,
                     genre: Faker::Book.genre, image: Faker::Internet.url)
  puts "Created book: #{book.inspect}" if book
end
