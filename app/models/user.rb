class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates_presence_of :name

  has_many :shops
  has_many :markets, through: :shops
  has_many :bank_accounts

  def default_bank_account
    @default_bank_account ||= bank_accounts.first
  end
end
