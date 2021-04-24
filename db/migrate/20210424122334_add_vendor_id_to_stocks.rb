class AddVendorIdToStocks < ActiveRecord::Migration[6.1]
  def change
    add_column :stocks, :vendor_id, :string
  end
end
