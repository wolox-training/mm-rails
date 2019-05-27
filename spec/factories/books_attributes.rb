FactoryBot.define do
  trait :books_attributes do
    author { Faker::Book.author }
    title { Faker::Book.title }
    publisher { Faker::Book.publisher }
    year { Faker::Number.positive.truncate.to_s }
  end
end
