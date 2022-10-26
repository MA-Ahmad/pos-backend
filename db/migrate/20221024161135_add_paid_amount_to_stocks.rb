class AddPaidAmountToStocks < ActiveRecord::Migration[6.1]
  def change
    add_column :stocks, :paid_amount, :float
  end
end
