FactoryBot.define do
  factory :book_suggestion do
    books_attributes
    synopsis { Faker::String.random }
    price { Faker::Number.decimal(2) }
    link { Faker::String.random }
    user
  end
end
