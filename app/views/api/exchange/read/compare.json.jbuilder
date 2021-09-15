json.array! @compare_currency_list do |compare_currency|
  json.date @base_currency_info.date
  json.name "#{@base_currency}/#{compare_currency}"
  json.rate @base_currency_info.compare_with(compare_currency)
end
