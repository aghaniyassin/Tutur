class Car < ApplicationRecord
  MILEAGE_STEP = 25_000
  enum brand: [:renault, :peugeot, :citroen, :fiat]
  enum model: [:clio, :megane, :punto, :boxer, :picasso]
  enum energy: [:gasoline, :diesel, :electric, :autogas]
  enum transmission: [:automatic, :manual, :other]
  enum category: [:sedan, :familial, :city, :van]
  enum mileage: (0..MILEAGE_STEP*12).step(MILEAGE_STEP)
                    .map {|x| "#{x}-#{x + MILEAGE_STEP}"}

  validates :description, length: { minimum: 20 }
  validates :brand, inclusion: { in: brands.keys }
  validates :model, inclusion: { in: models.keys }
  validates :price, presence: true
  validates :street, presence: true
  validates :city, presence: true
  validates :postal_code, presence: true

  belongs_to :user
  has_many :rentals
  has_one_attached :image
  accepts_nested_attributes_for :rentals

  geocoded_by :address
  after_validation :geocode
  attr_accessor :radius

  def image_url
    if image.attached?
      image
    else
      'https://drivy.imgix.net/uploads/originals/d064f4da514ee8fb6142abb776df1e06.jpeg'
    end
  end

  def address
    [street, city, postal_code, country].compact.join(', ')
  end

  def title
    "#{self.brand.humanize} #{self.model.humanize}"
  end

  def humanize_price
    "#{price}$ per day"
  end

  def last_rental
    rentals.last
  end

  scope :available_between, -> (desired_dates) do
    if desired_dates
      left_outer_joins(:rentals).where('"rentals"."status" IS NOT TRUE
                                        OR ((:desired_start < start_at AND :desired_end < start_at)
                                            OR (end_at < :desired_start AND end_at < :desired_end))',
                                        {desired_start: desired_dates[:start_at], desired_end: desired_dates[:end_at]}).group(:id)
    end
  end
end
