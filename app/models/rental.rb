class Rental < ApplicationRecord
  ERROR_DATE_MESSAGE = ' date of the rental is incorrect.'
  before_save :compute_amount
  validates :start_at, presence: true
  validates :end_at, presence: true
  validate :valid_dates
  validate :available

  belongs_to :user
  belongs_to :car

  def compute_amount
    self.amount = days * car.price if days
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

  def days
    ((end_at - start_at) / 1.day).to_i if end_at && start_at
  end

  def humanize_status
    case status when nil
      'Pending'
    when true
      'Accepted'
    when false
      'Rejected'
    end
  end

  def available
    return nil unless start_at && end_at
    if Rental.where(status: true, car_id: car.id)
             .where('? > start_at OR ? > start_at', start_at, end_at)
             .where('? < end_at OR ? < end_at', start_at, end_at).any?

      errors.add(:start_at, 'This car is unavailable on these dates')
    end
  end
end
