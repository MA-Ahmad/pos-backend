class AddSkuToStocks < ActiveRecord::Migration[6.1]
  def change
    add_column :stocks, :sku, :string
  end
end
