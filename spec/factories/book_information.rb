FactoryBot.define do
  factory :book_information, class: Hash do
    isbn { Faker::Number.number(10) }
    title { Faker::Book.title }
    subtitle { Faker::Books::Lovecraft.paragraph }
    number_of_pages { Faker::Number.within(1..1000) }
    authors do
      (1..Faker::Number.within(1..10)). map do
        Faker::Book.author
      end
    end
  end
end
