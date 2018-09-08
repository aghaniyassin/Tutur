class User < ApplicationRecord
  authenticates_with_sorcery!
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  before_save { self.email = email.downcase }
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }, if: -> { password.present? }
  validates :first_name, length: { minimum: 3 }
  validates :last_name, length: { minimum: 2 }
end
