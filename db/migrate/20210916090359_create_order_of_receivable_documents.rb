class CreateOrderOfReceivableDocuments < ActiveRecord::Migration[6.1]
  def change
    create_table :order_of_receivable_documents do |t|
      t.references :order, null: false, foreign_key: true
      t.references :receivable_document, null: false, foreign_key: true

      t.timestamps
    end
  end
end
