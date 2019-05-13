class Book < ApplicationRecord
  validates :genre, :author, :title, :publisher, :image, presence: true
  validates :year, presence: true, numericality: { only_integer: true }
end
