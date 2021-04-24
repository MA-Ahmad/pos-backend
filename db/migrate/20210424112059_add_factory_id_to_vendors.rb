class AddFactoryIdToVendors < ActiveRecord::Migration[6.1]
  def change
    add_column :vendors, :factory_id, :string
  end
end
