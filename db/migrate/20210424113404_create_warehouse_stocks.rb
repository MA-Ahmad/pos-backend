class CreateWarehouseStocks < ActiveRecord::Migration[6.1]
  def change
    create_table :warehouse_stocks do |t|

      t.timestamps
    end
  end
end
