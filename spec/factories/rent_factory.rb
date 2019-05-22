FactoryBot.define do
  factory :rent do
    book
    user
    starting_date { Faker::Date.forward }
    ending_date { Faker::Date.between(starting_date + 1, starting_date + 25) }
  end
end
