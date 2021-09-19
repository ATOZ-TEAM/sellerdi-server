class Market < ApplicationRecord
  has_many :shops
  has_many :users, through: :shops

  validates_presence_of :name, :country_code, :currency
end
