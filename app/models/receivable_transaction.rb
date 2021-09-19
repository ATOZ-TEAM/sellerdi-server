class ReceivableTransaction < ApplicationRecord
  belongs_to :document, class_name: 'ReceivableDocument', foreign_key: :receivable_document_id

  before_validation do
    return if persisted?

    self.start_currency = document.shop.market.currency
    self.final_currency ||= 'KRW'
    self.currency_ratio = ExchangeInfo.ratio_between(start_currency, final_currency)
    self.start_amount = document.order_amount_sum
    self.final_amount = (start_amount * currency_ratio).floor
  end
end
