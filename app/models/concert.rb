class Concert < ApplicationRecord
    has_many :reservations, dependent: :delete_all

    validates :title, presence: true
end
