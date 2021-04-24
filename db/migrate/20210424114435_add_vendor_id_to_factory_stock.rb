class AddVendorIdToFactoryStock < ActiveRecord::Migration[6.1]
  def change
    add_column :factory_stocks, :vendor_id, :string
  end
end
