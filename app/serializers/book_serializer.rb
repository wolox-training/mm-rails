class BookSerializer < ActiveModel::Serializer
  attributes :id, :author, :title, :publisher, :year, :genre
  attribute :image, key: :image_url
  has_one :actual_rent, serializer: ActualRentSerializer
end
