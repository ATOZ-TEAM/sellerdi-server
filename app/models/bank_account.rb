class BankAccount < ApplicationRecord
  belongs_to :user
  has_many :receivable_documents, dependent: :nullify
end
