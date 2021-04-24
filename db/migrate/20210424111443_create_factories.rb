class CreateFactories < ActiveRecord::Migration[6.1]
  def change
    create_table :factories do |t|

      t.timestamps
    end
  end
end
