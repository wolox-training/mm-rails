class RentSerializer < ActiveModel::Serializer
  attributes :id, :starting_date, :ending_date

  has_one :book, serializer: BookSerializer
  has_one :user, serializer: UserSerializer
end
