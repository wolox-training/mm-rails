class RentSerializer < ActiveModel::Serializer
  attributes :id, :from, :to

  has_one :book, serializer: BookSerializer
  has_one :user, serializer: UserSerializer

  def from
    object.starting_date
  end

  def to
    object.ending_date
  end
end
