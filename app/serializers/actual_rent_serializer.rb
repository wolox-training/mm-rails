class ActualRentSerializer < ActiveModel::Serializer
  attributes :id, :starting_date, :ending_date, :book, :user
end
