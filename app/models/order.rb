class Order < ApplicationRecord
  belongs_to :shop
  has_many :order_of_receivable_documents

  serialize :transaction_data, OrderTransactionData

  def amount
    transaction_data.amount
  end
end
