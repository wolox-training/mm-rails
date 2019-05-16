class BookPreviewSerializer < ActiveModel::Serializer
  attributes :id, :author, :title, :publisher, :year, :genre, :created_at, :updated_at
  attribute(:image) do
    { url: object.image }
  end
end
