class CreateExchangeInfoRequestLogs < ActiveRecord::Migration[6.1]
  def change
    create_table :exchange_info_request_logs do |t|
      t.datetime :requested_at

      t.timestamps
    end
  end
end
