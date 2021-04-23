class Vendor < ApplicationRecord
    validates :name, uniqueness: true, presence: true
    has_many :stocks
end
