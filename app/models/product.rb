class Product < ApplicationRecord
    validates :name, uniqueness: true, presence: true
    belongs_to :company
    has_many :stocks
    has_many :transaction_records, dependent: :destroy
    # has_one :transaction, through: :transaction_record
end
