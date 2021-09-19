class CreateMarkets < ActiveRecord::Migration[6.1]
  def change
    create_table :markets do |t|
      t.string :name
      t.string :country_code
      t.string :currency

      t.timestamps
    end
  end
end
