class Usernumber < ApplicationRecord
    validates :phone, presence: true
end
