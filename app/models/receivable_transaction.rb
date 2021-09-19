# == Schema Information
#
# Table name: receivable_transactions
#
#  id                     :bigint           not null, primary key
#  currency_ratio         :float(24)
#  final_amount           :float(24)
#  final_currency         :string(255)
#  start_amount           :float(24)
#  start_currency         :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  receivable_document_id :bigint           not null
#
# Indexes
#
#  index_receivable_transactions_on_receivable_document_id  (receivable_document_id)
#
# Foreign Keys
#
#  fk_rails_...  (receivable_document_id => receivable_documents.id)
#
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
