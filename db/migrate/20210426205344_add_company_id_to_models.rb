class AddCompanyIdToModels < ActiveRecord::Migration[6.1]
  def change
    add_reference :stocks, :company, type: :uuid, null: false, foreign_key: true
    add_reference :users, :company, type: :uuid, null: false, foreign_key: true
    add_reference :products, :company, type: :uuid, null: false, foreign_key: true
    add_reference :vendors, :company, type: :uuid, null: false, foreign_key: true
  end
end
