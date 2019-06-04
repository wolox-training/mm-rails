[*1..50_000].each do
  book = Book.create(author: Faker::Book.author, title: Faker::Book.title.first(25),
                     publisher: Faker::Book.publisher, year: Faker::Number.positive.truncate.to_s,
                     genre: Faker::Book.genre, image: Faker::Internet.url)
  puts "Created book: #{book.inspect}" if book
end
