class ActualRentSerializer < ActiveModel::Serializer
  attributes :id, :starting_date, :ending_date, :book_id, :user_id
end
