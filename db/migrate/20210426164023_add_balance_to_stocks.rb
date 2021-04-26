class AddBalanceToStocks < ActiveRecord::Migration[6.1]
  def change
    add_column :stocks, :balance, :float
  end
end
