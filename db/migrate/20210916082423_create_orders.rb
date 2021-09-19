class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      # 샵
      t.references :shop, null: false, foreign_key: true

      # 주문건의 대표 이미지
      t.string :first_item_img

      # 마켓플레이스에 표기된 주문일시
      t.datetime :date

      # 마켓플레이스에서 취급하는 주문번호
      t.string :order_id

      # json field : {
      #   amount: 72.39,
      #   symbol: "RM"
      # }
      t.text :transaction_data

      # 주문 상태 (메세지)
      t.string :status_message

      t.timestamps
    end
  end
end
