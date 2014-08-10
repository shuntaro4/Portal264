class Concert < ActiveRecord::Base
    has_many :reservations
end
