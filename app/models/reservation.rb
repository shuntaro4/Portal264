class Reservation < ApplicationRecord
  belongs_to :concert
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :concert, presence: true
  validates :name, presence: true
  validates :mail, presence: true, format: {with: VALID_EMAIL_REGEX}
  validates :ticket, presence: true, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 100 }
end
