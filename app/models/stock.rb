class Stock < ApplicationRecord
  belongs_to :vendor, required: false
  belongs_to :product
end
