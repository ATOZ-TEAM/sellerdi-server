# == Schema Information
#
# Table name: receivable_bonds
#
#  id                     :bigint           not null, primary key
#  coupon_rate            :float(24)
#  issue_date             :date
#  maturity_date          :date
#  par_value              :float(24)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  receivable_document_id :bigint           not null
#
# Indexes
#
#  index_receivable_bonds_on_receivable_document_id  (receivable_document_id)
#
# Foreign Keys
#
#  fk_rails_...  (receivable_document_id => receivable_documents.id)
#
class ReceivableBond < ApplicationRecord
  belongs_to :document, class_name: 'ReceivableDocument', foreign_key: :receivable_document_id

  before_validation do
    align_data unless persisted?
  end

  private

  def align_data
    self.issue_date = document.released_at.to_date.to_s
    self.par_value = document.captured_transaction.final_amount
    self
  end
end
