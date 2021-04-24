class CreateColdStorages < ActiveRecord::Migration[6.1]
  def change
    create_table :cold_storages do |t|

      t.timestamps
    end
  end
end
