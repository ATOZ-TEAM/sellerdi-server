class CreateReceivableDocuments < ActiveRecord::Migration[6.1]
  def change
    create_table :receivable_documents do |t|
      t.references :shop, null: false, foreign_key: true
      t.references :bank_account, null: false, foreign_key: true
      t.datetime :released_at
      t.text :received_bank_account
      t.integer :order_count, null: false, default: 0
      t.float :order_amount_sum, null: false, default: 0.0

      t.timestamps
    end
  end
end
