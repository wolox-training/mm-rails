FactoryBot.define do
  factory :book_suggestion do
    author { Faker::Book.author }
    title { Faker::Book.title }
    publisher { Faker::Book.publisher }
    year { Faker::Number.positive.truncate.to_s }
    synopsis { Faker::Lorem.paragraph }
    price { Faker::Number.decimal(2) }
    link { Faker::Internet.url }
    user
  end
end
