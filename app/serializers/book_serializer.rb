class BookSerializer < ActiveModel::Serializer
  attributes :id, :author, :title, :genre, :publisher, :year, :image_url

  def image_url
    object.image
  end

  has_one :actual_rent, serializer: ActualRentSerializer
end
