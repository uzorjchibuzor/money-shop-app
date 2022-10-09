class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.integer :type, null: false
      t.integer :amount, default: 0, null: false
      t.date :date, null: false
      t.datetime :time, null: false

      t.references :user, null: false, foreign_key: true
      t.timestamps
    end

    add_index :transactions, :time
  end
end
