class OrderOfReceivableDocument < ApplicationRecord
  belongs_to :order, optional: true
  belongs_to :receivable_document

  delegate :amount, to: :order

  after_create -> { receivable_document.update(order_amount_sum: receivable_document.order_amount_sum += amount) }
  after_destroy -> { receivable_document.update(order_amount_sum: receivable_document.order_amount_sum -= amount) }
end
