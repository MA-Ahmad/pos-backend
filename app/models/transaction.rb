class Transaction < ApplicationRecord
  has_many :transaction_records, dependent: :destroy
  has_many :products, through: :transaction_record
end
