class Vendor < ApplicationRecord
    validates :name, uniqueness: { scope: :company, message: 'duplicate name not allowed' }
    validates :name, presence: true
    belongs_to :company
    has_many :stocks
end
