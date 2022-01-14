class CreateTransactionRecords < ActiveRecord::Migration[6.1]
  def change
    create_table :transaction_records do |t|
      t.references :product, null: false, foreign_key: true
      t.references :transaction, null: false, foreign_key: true
      t.float :quantity

      t.timestamps
    end
  end
end
