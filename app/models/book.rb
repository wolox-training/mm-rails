class Book < ApplicationRecord
  validates_presence_of :genre, :author, :title, :publisher, :image
  validates :year, presence: true, numericality: { only_integer: true }
end
