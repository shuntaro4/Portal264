class Concert < ApplicationRecord
  validates :title, presence: true
  geocoded_by :address
  after_validation :geocode, if: :address_changed?
end
