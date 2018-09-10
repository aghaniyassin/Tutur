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

  belongs_to :user
  has_many :rentals
  accepts_nested_attributes_for :rentals
  
  def title
    "#{self.brand.humanize} #{self.model.humanize}"
  end
end
