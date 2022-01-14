class ShopStock < Stock
  validates :sku, presence: true
  validates_uniqueness_of :sku, scope: :company_id
end
