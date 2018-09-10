class Rental < ApplicationRecord
  ERROR_DATE_MESSAGE = ' date of the rental is incorrect.'
  before_save :compute_amount
  validates :start_at, presence: true
  validates :end_at, presence: true
  validate :valid_dates

  belongs_to :user
  belongs_to :car

  def compute_amount
    self.amount = ((self.end_at - self.start_at) / 1.day).to_i * car.price
  end

  def start_at_in_future
    start_at && start_at > DateTime.now
  end

  def end_at_after_start_at
    end_at && start_at && (end_at > start_at)
  end

  def valid_dates?
    start_at_in_future && end_at_after_start_at
  end

  def valid_dates
    errors.add :start_at, ERROR_DATE_MESSAGE unless valid_dates?
  end
end
