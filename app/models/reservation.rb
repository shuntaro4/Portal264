class Reservation < ActiveRecord::Base
    belongs_to :concert
end
