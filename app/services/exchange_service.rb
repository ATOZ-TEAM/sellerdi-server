module ExchangeService
  class UpdateService
    def self.call
      last_request = ExchangeInfoRequestLog.last

      # 현재 시간을 직전 풀링 시간과 비교해서
      # 시 단위가 변경되었으면, 다시 폴링 + 저장.
      if last_request.nil? || last_request.requested_at.hour < Time.zone.now.hour
        last_request = ExchangeInfoRequestLog.create_with_new_data
      end

      last_request
    end
  end
end
