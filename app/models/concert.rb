class Concert < ActiveRecord::Base
    has_many :reservations, dependent: :delete_all

    validates :title, presence: true
end
