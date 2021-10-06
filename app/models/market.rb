# == Schema Information
#
# Table name: markets
#
#  id           :bigint           not null, primary key
#  country_code :string(255)
#  currency     :string(255)
#  name         :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Market < ApplicationRecord
  has_many :shops
  has_many :users, through: :shops

  validates_presence_of :name, :country_code, :currency

  def title
    "#{name} - #{country_code}"
  end
end
