class Ticket < ApplicationRecord
    has_one :client
    has_one :product
    has_one :seller

end
