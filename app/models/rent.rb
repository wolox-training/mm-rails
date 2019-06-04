class Rent < ApplicationRecord
  belongs_to :user
  belongs_to :book
  validates :user, :book, :starting_date, :ending_date, presence: true
  validate :end_after_start, :starting_must_be_after_year_1900
  scope :expiring_today, -> { where(ending_date: Time.zone.today) }

  def end_after_start
    return if starting_date.nil? || ending_date.nil?

    errors[:ending_date] << 'Ending date must be after starting date' if
      ending_date < starting_date
  end

  def starting_must_be_after_year_1900
    return if starting_date.nil? || ending_date.nil?

    errors[:starting_date] << 'Starting date must be after year 1900' if starting_date.year < 1900
  end
end
