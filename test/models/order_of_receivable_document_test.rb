# == Schema Information
#
# Table name: order_of_receivable_documents
#
#  id                     :bigint           not null, primary key
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  order_id               :bigint           not null
#  receivable_document_id :bigint           not null
#
# Indexes
#
#  index_order_of_receivable_documents_on_order_id                (order_id)
#  index_order_of_receivable_documents_on_receivable_document_id  (receivable_document_id)
#
# Foreign Keys
#
#  fk_rails_...  (order_id => orders.id)
#  fk_rails_...  (receivable_document_id => receivable_documents.id)
#
require "test_helper"

class OrderOfReceivableDocumentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
