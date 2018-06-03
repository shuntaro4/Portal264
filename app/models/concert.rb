class Concert < ApplicationRecord
  validates :title, presence: true
end
