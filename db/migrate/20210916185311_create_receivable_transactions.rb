class CreateReceivableTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :receivable_transactions do |t|
      t.references :receivable_document, null: false, foreign_key: true
      t.string :start_currency
      t.float :start_amount
      t.string :final_currency
      t.float :final_amount
      t.float :currency_ratio

      t.timestamps
    end
  end
end
