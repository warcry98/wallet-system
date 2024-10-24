class CreateTransactions < ActiveRecord::Migration[7.2]
  def change
    create_table :transactions do |t|
      t.references :source_wallet, null: true, foreign_key: { to_table: :wallets } # Null for credits
      t.references :target_wallet, null: true, foreign_key: { to_table: :wallets } # Null for debits
      t.decimal :amount, precision: 15, scale: 2, null: false
      t.string :transaction_type, null: false # Credit, Debit, Transfer

      t.timestamps
    end
  end
end
