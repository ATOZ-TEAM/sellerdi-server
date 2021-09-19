class Shop < ApplicationRecord
  belongs_to :user
  belongs_to :market
  has_many :orders
  has_many :receivable_documents
end
