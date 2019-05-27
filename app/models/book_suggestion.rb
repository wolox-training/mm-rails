class BookSuggestion < ApplicationRecord
  validates :author, :title, :publisher, presence: true
  validates :year, presence: true,
                   numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :link, url: true, presence: true

  belongs_to :user, optional: true
end
