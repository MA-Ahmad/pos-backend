class MadeChangesInStocks < ActiveRecord::Migration[6.1]
  def change
    remove_column :stocks, :vendor_id
    add_column :stocks, :type, :string
  end
end
