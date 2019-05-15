class Rent < ApplicationRecord
  belongs_to :user
  belongs_to :book
  validates :user, :book, :from, :to, presence: true
end
