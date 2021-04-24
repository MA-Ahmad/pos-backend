class StockSerializer < ActiveModel::Serializer
  attributes :id, :quantity, :price, :type, :vendor_id, :product_id
  has_one :product
  has_one :vendor
  # belongs_to :product, serializer: ProductSerializer
  # belongs_to :vendor, serializer: VendorSerializer
end
