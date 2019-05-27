FactoryBot.define do
  factory :book do
    books_attributes
    genre { Faker::Book.genre }
    image { Faker::Alphanumeric.alphanumeric 25 }
  end
end
