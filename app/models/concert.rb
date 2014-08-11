class Concert < ActiveRecord::Base
    has_many :reservations, dependent: :delete_all
end
