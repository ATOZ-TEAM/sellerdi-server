# == Schema Information
#
# Table name: exchange_info_request_logs
#
#  id           :bigint           not null, primary key
#  requested_at :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class ExchangeInfoRequestLog < ApplicationRecord
  has_many :exchange_infos
  accepts_nested_attributes_for :exchange_infos

  validates_presence_of :requested_at
  make_default_value_of_column :requested_at, -> { Time.zone.now }

  class << self
    def create_with_new_data
      transaction do
        create(requested_at: Time.zone.now).tap do |log|
          fetch_new_dataset.each do |exchange_info_source_data|
            log.exchange_infos.create(exchange_info_source_data)
          end
        end
      end
    end

    private

    def fetch_new_dataset
      JSON.parse Faraday.get('https://api.manana.kr/exchange.json').body
    end
  end
end
