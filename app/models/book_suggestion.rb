class BookSuggestion < ApplicationRecord
  validates :author, :title, :link, :publisher, presence: true
  validates :year, presence: true, numericality: { only_integer: true }

  belongs_to :user, optional: true
end
