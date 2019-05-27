class BookSuggestion < ApplicationRecord
  validates :author, :title, :publisher, presence: true
  validates :year, presence: true, numericality: { only_integer: true }
  validates :link, url: true, presence: true

  belongs_to :user, optional: true
end
