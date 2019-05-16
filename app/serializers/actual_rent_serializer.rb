class ActualRentSerializer < ActiveModel::Serializer
  attributes :id, :book_id, :user_id
  attribute :starting_date, key: :from
  attribute :ending_date, key: :to
end
