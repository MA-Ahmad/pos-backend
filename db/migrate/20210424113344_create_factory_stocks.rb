class CreateFactoryStocks < ActiveRecord::Migration[6.1]
  def change
    create_table :factory_stocks do |t|

      t.timestamps
    end
  end
end
