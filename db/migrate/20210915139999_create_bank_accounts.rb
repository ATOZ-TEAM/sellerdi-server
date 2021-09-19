class CreateBankAccounts < ActiveRecord::Migration[6.1]
  def change
    create_table :bank_accounts do |t|
      t.references :user, null: false, foreign_key: true
      t.string :account_num
      t.string :bank_name
      t.string :holder_name

      t.timestamps
    end
  end
end
