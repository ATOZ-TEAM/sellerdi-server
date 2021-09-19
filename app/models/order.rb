# == Schema Information
#
# Table name: orders
#
#  id               :bigint           not null, primary key
#  date             :datetime
#  first_item_img   :string(255)
#  status_message   :string(255)
#  transaction_data :text(65535)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  order_id         :string(255)
#  shop_id          :bigint           not null
#
# Indexes
#
#  index_orders_on_shop_id  (shop_id)
#
# Foreign Keys
#
#  fk_rails_...  (shop_id => shops.id)
#
class Order < ApplicationRecord
  belongs_to :shop
  has_many :order_of_receivable_documents

  serialize :transaction_data, OrderTransactionData

  def amount
    transaction_data.amount
  end
end
