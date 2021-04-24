class CreateColdstorageStocks < ActiveRecord::Migration[6.1]
  def change
    create_table :coldstorage_stocks do |t|

      t.timestamps
    end
  end
end
