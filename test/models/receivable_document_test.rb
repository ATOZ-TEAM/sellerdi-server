# == Schema Information
#
# Table name: receivable_documents
#
#  id                    :bigint           not null, primary key
#  order_amount_sum      :float(24)        default(0.0), not null
#  order_count           :integer          default(0), not null
#  received_bank_account :text(65535)
#  released_at           :datetime
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  bank_account_id       :bigint           not null
#  shop_id               :bigint           not null
#
# Indexes
#
#  index_receivable_documents_on_bank_account_id  (bank_account_id)
#  index_receivable_documents_on_shop_id          (shop_id)
#
# Foreign Keys
#
#  fk_rails_...  (bank_account_id => bank_accounts.id)
#  fk_rails_...  (shop_id => shops.id)
#
require "test_helper"

class ReceivableDocumentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
