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
require "test_helper"

class ReceivableTransactionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
