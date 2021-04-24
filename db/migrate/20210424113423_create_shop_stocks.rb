class CreateShopStocks < ActiveRecord::Migration[6.1]
  def change
    create_table :shop_stocks do |t|

      t.timestamps
    end
  end
end
