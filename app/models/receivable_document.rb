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
class ReceivableDocument < ApplicationRecord
  belongs_to :shop
  belongs_to :bank_account, optional: true
  has_many :order_of_receivable_documents, dependent: :destroy
  has_many :orders, through: :order_of_receivable_documents
  has_one :captured_transaction, class_name: 'ReceivableTransaction'
  has_one :bond, class_name: 'ReceivableBond'

  serialize :received_bank_account, HashSerializer
  validates_presence_of :received_bank_account

  make_default_value_of_column :bank_account, -> { shop.user.default_bank_account }
  make_default_value_of_column :released_at, -> { Time.zone.now }
  make_default_value_of_column :received_bank_account, -> { bank_account&.as_json }, repeat: true

  def issue!(maturity_date:, coupon_rate:)
    # record captured transaction
    create_captured_transaction

    # record bond information
    create_bond(maturity_date: maturity_date, coupon_rate: coupon_rate)
  end

  def issue_reload!
    # refresh captured transaction
    captured_transaction.send(:align_data).save!

    # refresh bond information
    bond.send(:align_data).save!
  end
end
