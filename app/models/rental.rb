class Rental < ApplicationRecord
  ERROR_DATE_MESSAGE = ' date of the rental is incorrect.'
  belongs_to :user
  belongs_to :car
  before_save :compute_amount
  validates :start_at, presence: true
  validates :end_at, presence: true
  validate :start_at_in_future
  validate :end_at_after_start_at

  def compute_amount
    self.amount = ((self.end_at - self.start_at) / 1.day).to_i * car.price
  end

  def start_at_in_future
    if start_at && start_at < DateTime.now
      errors.add :start_at, ERROR_DATE_MESSAGE
    end
  end

  def end_at_after_start_at
    if (end_at && start_at) && end_at < start_at
      errors.add :start_at, ERROR_DATE_MESSAGE
    end
  end

  def overlaps?(other)
    start_at <= other.end_at && other.start_at <= end_at
  end

  # Return a scope for all interval overlapping the given interval, excluding the given interval itself
  scope :overlapping, -> (inquiry_start_at, inquiry_end_at) {
    where.not("start_at <= ? AND ? <= end_at", inquiry_end_at, inquiry_start_at)
  }
end
