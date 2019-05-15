class Rent < ApplicationRecord
  belongs_to :user
  belongs_to :book
  validates :user, :book, :starting_date, :ending_date, presence: true
end
