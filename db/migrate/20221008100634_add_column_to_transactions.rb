class AddColumnToTransactions < ActiveRecord::Migration[7.0]
  def change
    add_column :transactions, :charges, :integer, default: 0
  end
end
