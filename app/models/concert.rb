class Concert < ApplicationRecord
  has_many :reservations, dependent: :delete_all

  validates :title, presence: true
  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  scope :active, -> { where(active: true) }
end
