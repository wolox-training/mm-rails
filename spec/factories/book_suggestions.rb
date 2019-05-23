FactoryBot.define do
  factory :book_suggestion do
<<<<<<< HEAD
    author { Faker::Book.author }
    title { Faker::Book.title }
    publisher { Faker::Book.publisher }
    year { Faker::Number.positive.truncate.to_s }
    synopsis { Faker::Lorem.paragraph }
    price { Faker::Number.decimal(2) }
    link { Faker::Internet.url }
=======
    books_attributes
    synopsis { Faker::String.random.gsub("\u0000", '') }
    price { Faker::Number.decimal(2) }
    link { Faker::String.random.gsub("\u0000", '') }
>>>>>>> 5c6edb9... Adding book_suggestion controller test cases
    user
  end
end
