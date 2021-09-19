class ExchangeInfo < ApplicationRecord
  belongs_to :request_log, class_name: 'ExchangeInfoRequestLog', foreign_key: :exchange_info_request_log_id

  scope :find_by_recent_currency, ->(currency) { where(currency: currency).last }

  def self.ratio_between(base, final)
    find_by_recent_currency(base).compare_with(final)
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
