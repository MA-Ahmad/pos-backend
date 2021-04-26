class Company < ApplicationRecord
    has_many :users
    has_many :products
    has_many :vendors
    has_many :stocks
end
