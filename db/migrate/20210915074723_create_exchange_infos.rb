class CreateExchangeInfos < ActiveRecord::Migration[6.1]
  def change
    create_table :exchange_infos do |t|
      t.references :exchange_info_request_log, null: false, foreign_key: true
      t.string :symbol
      t.virtual :currency, type: :string, as: "SUBSTRING(symbol, 1, 3)", stored: true
      t.string :name
      t.float :price
      t.datetime :date
      t.integer :timestamp
      t.string :kr
      t.string :en
      t.string :jp

      t.timestamps
    end
  end
end
