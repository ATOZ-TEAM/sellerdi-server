class ReceivableBond < ApplicationRecord
  belongs_to :document, class_name: 'ReceivableDocument', foreign_key: :receivable_document_id

  before_validation do
    return if persisted?

    self.issue_date ||= document.released_at.to_date.to_s
    self.par_value ||= document.captured_transaction.final_amount
  end
end
