class ReceivableDocument < ApplicationRecord
  belongs_to :shop
  belongs_to :bank_account, optional: true
  has_many :order_of_receivable_documents, dependent: :destroy, counter_cache: true
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
end
