# == Schema Information
#
# Table name: bank_accounts
#
#  id          :bigint           not null, primary key
#  account_num :string(255)
#  bank_name   :string(255)
#  holder_name :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_bank_accounts_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class BankAccount < ApplicationRecord
  belongs_to :user
  has_many :receivable_documents, dependent: :nullify
end
