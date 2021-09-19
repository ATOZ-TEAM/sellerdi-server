class CreateShops < ActiveRecord::Migration[6.1]
  def change
    create_table :shops do |t|
      t.references :user, null: false, foreign_key: true
      t.references :market, null: false, foreign_key: true
      t.string :account
      t.string :password

      t.timestamps
    end
  end
end
