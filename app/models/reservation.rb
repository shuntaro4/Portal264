class Reservation < ApplicationRecord
    belongs_to :concert

    validates :concert,
              presence: true
    validates :name,
              presence: true,
              length: { maximum: 30 }
    validates :mail,
              presence: true,
              length: { maximum: 50 },
              format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }
    validates :ticket,
              presence: true,
              numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 100 }
end
