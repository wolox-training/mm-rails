class ActualRentSerializer < ActiveModel::Serializer
  attributes :id, :from, :to, :book_id, :user_id

  def from
    object.starting_date
  end

  def to
    object.ending_date
  end
end
