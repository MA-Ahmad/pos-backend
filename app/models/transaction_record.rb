class TransactionRecord < ApplicationRecord
  belongs_to :product
  # belongs_to :transaction, class_name: 'Transaction'
  belongs_to :inventory, foreign_key: "transaction_id", class_name: "Transaction"
end
