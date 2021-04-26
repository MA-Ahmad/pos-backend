class Product < ApplicationRecord
    validates :name, uniqueness: true, presence: true
    belongs_to :company
    has_many :stocks
end
