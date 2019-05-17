class Book < ApplicationRecord
  validates :genre, :author, :title, :publisher, :image, presence: true
  validates :year, presence: true, numericality: { only_integer: true }

  scope :author, ->(author) { where author: author }
  scope :genre, ->(genre) { where genre: genre }
  scope :title, ->(title) { where title: title }

  Reducer = Rack::Reducer.new(
    Book.all,
    ->(author:) { where(author: author) },
    ->(genre:) { where(genre: genre) },
    ->(title:) { where(title: title) }
  )

  has_many :rents, dependent: :destroy

  def actual_rent
    rents.find_by(':current_date between starting_date and ending_date',
                  current_date: Time.zone.today)
  end
end
