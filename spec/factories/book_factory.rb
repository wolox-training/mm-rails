FactoryBot.define do
  factory :book do
    author { Faker::Book.author }
    title { Faker::Book.title.first 25 }
    publisher { Faker::Book.publisher }
    year { Faker::Number.positive.truncate.to_s }
    genre { Faker::Book.genre }
    image { Faker::Alphanumeric.alphanumeric 25 }
  end
end
