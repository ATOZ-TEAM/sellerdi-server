module Api
  module Exchange
    class ReadController < BaseController
      def all
        last_request_log = ExchangeInfoRequestLog.last

        unless last_request_log
          last_request_log = ExchangeService::UpdateService.call
        end

        @exchange_infos = last_request_log.exchange_infos.where.not(kr: nil).where.not(en: nil)
      end

      def compare
        @base_currency = params[:base_currency].presence
        @compare_currency_list = params[:compare_currency_list].presence.gsub(' ', '').split(',')
        @base_currency_info = ExchangeInfo.find_by_recent_currency(@base_currency)
      end
    end
  end
end
