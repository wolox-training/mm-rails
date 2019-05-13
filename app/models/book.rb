class Book < ApplicationRecord
  validates :genre, :author, :title, :publisher, :image, presence: true
  validates :year, presence: true, numericality: { only_integer: true }

  scope :author, ->(author) { where author: author }
  scope :genre, ->(genre) { where genre: genre }
  scope :title, ->(title) { where title: title }
  scope :description, ->(description) { where description: description }

  Reducer = Rack::Reducer.new(
    Book.all,
    ->(author:) { where(author: author) },
    ->(genre:) { where(genre: genre) },
    ->(title:) { where(title: title) },
    ->(description:) { where(description: description) }
  )
end
