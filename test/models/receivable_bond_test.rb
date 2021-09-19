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
require "test_helper"

class ReceivableBondTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
