# == Schema Information
#
# Table name: exchange_infos
#
#  id                           :bigint           not null, primary key
#  currency                     :string(255)
#  date                         :datetime
#  en                           :string(255)
#  jp                           :string(255)
#  kr                           :string(255)
#  name                         :string(255)
#  price                        :float(24)
#  symbol                       :string(255)
#  timestamp                    :integer
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#  exchange_info_request_log_id :bigint           not null
#
# Indexes
#
#  index_exchange_infos_on_exchange_info_request_log_id  (exchange_info_request_log_id)
#
# Foreign Keys
#
#  fk_rails_...  (exchange_info_request_log_id => exchange_info_request_logs.id)
#
class ExchangeInfo < ApplicationRecord
  belongs_to :request_log, class_name: 'ExchangeInfoRequestLog', foreign_key: :exchange_info_request_log_id

  scope :find_by_recent_currency, ->(currency) { where(currency: currency).last }

  def self.ratio_between(base, final)
    find_by_recent_currency(final).compare_with(base)
  end

  def compare_with(currency)
    case currency
    when String
      price / self.class.find_by_recent_currency(currency).price
    when ExchangeInfo
      price / currency.price
    else
      price
    end
  end
end
