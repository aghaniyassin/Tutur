class Rental < ApplicationRecord
  ERROR_DATE_MESSAGE = ' date of the rental is incorrect.'
  before_save :compute_amount
  validates :start_at, presence: true
  validates :end_at, presence: true
  validate :start_at_in_future
  validate :end_at_after_start_at

  belongs_to :user
  belongs_to :car

  def compute_amount
    amount = ((end_at - start_at) / 1.day).to_i * car.price
  end

  def add_error_date_message
    errors.add :start_at, ERROR_DATE_MESSAGE
  end

  def start_at_in_future
    if start_at && start_at < DateTime.now
      add_error_date_message
    end
  end

  def end_at_after_start_at
    if (end_at && start_at) && end_at < start_at
      add_error_date_message
    end
  end
end
