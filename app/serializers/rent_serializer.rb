class RentSerializer < ActiveModel::Serializer
  attributes :id, :from, :to, :book, :user

  def from
    object.starting_date
  end

  def to
    object.ending_date
  end
end
