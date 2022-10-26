class Stock < ApplicationRecord
  before_save :round_values
  before_create :handle_stock
  validates :price, :quantity, :type, presence: true
  # validates_uniqueness_of :sku, scope: :company_id
  belongs_to :company
  belongs_to :vendor, required: false
  belongs_to :product

  def round_values
    self.quantity = Float(self.quantity).round(2)
    self.price = Float(self.price).round(2)
  end

  STOCK_TYPES = { cold: 'ColdstorageStock', warehouse: 'WarehouseStock', shop: 'ShopStock'}
  STOCK_CATEGORIES = ['FactoryStock', 'ColdstorageStock', 'WarehouseStock', 'ShopStock']

  def handle_stock
    cat_index = STOCK_CATEGORIES.index(type)
    params_quantity = Float(quantity)
    if STOCK_CATEGORIES.include?(type) && cat_index != 0
      (cat_index - 1).downto(0) do |i|
        model_name = STOCK_CATEGORIES[i].constantize
        stocks = model_name.where(product_id: product_id)
        stocks.order(created_at: :desc).each do |stock|
          if stock.quantity > params_quantity && params_quantity > 0
              stock.decrement!(:quantity, params_quantity)
              params_quantity = 0
          elsif params_quantity > 0
              params_quantity -= stock.quantity
              stock.decrement!(:quantity, stock.quantity)
              stock.destroy
          end
        end
        break if params_quantity.zero?
      end
      throw(:abort) unless params_quantity.zero?
    end
  end

  # def handle_stock
  #   if ['ColdstorageStock', 'WarehouseStock', 'ShopStock'].include? type
  #     stocks = get_stocks type
  #     stocks_sum = stocks.sum(:quantity)
  #     params_quantity = Float(quantity)
  #     if stocks_sum >= params_quantity
  #       stocks_total_larger_case stocks_sum, params_quantity, stocks 
  #     else
  #       # self.errors.add(:base, 'No stock available') && false
  #       throw(:abort)
  #     end
  #   end
  # end

  def handle_top_order params_quantity
    params_quantity = Float(params_quantity)
    obj_quantity = Float(quantity)
    if (['ColdstorageStock', 'WarehouseStock', 'ShopStock'].include? type) && obj_quantity != params_quantity
      stocks = get_stocks type
      stocks_sum = stocks.sum(:quantity)
      if params_quantity > obj_quantity
        params_quantity -= obj_quantity
        if stocks_sum >= params_quantity
          stocks_total_larger_case stocks_sum, params_quantity, stocks
        else
          false
        end 
      else
        params_quantity = obj_quantity - params_quantity
        stocks.order(created_at: :desc).last.increment!(:quantity, params_quantity) if stocks.present?
        true
      end
    else
      true
    end
  end

  def stocks_total_larger_case stocks_sum, params_quantity, stocks
    stocks.order(created_at: :desc).each do |stock|
      if stock.quantity > params_quantity && params_quantity > 0
          stock.decrement!(:quantity, params_quantity)
          params_quantity = 0
      elsif params_quantity > 0
          params_quantity -= stock.quantity
          stock.decrement!(:quantity, stock.quantity)
          stock.destroy
      end
    end
  end

  def get_stocks type
    case type
    when STOCK_TYPES[:cold]
      FactoryStock.where(product_id: product_id)
    when STOCK_TYPES[:warehouse]
      ColdstorageStock.where(product_id: product_id)
    when STOCK_TYPES[:shop]
      WarehouseStock.where(product_id: product_id)
    end
    if type == 'ColdstorageStock'
      FactoryStock.where(product_id: product_id)
    elsif type == 'WarehouseStock'
      ColdstorageStock.where(product_id: product_id)
    elsif type == 'ShopStock'
      WarehouseStock.where(product_id: product_id)
    end
  end
end
