class CreateReceivableBonds < ActiveRecord::Migration[6.1]
  def change
    create_table :receivable_bonds do |t|
      t.references :receivable_document, null: false, foreign_key: true
      t.date :issue_date
      t.date :maturity_date
      t.float :par_value
      t.float :coupon_rate

      t.timestamps
    end
  end
end
