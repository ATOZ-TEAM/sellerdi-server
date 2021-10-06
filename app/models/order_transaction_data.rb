require 'action_view/helpers/number_helper'

class OrderTransactionData
  include ::ActionView::Helpers::NumberHelper
  include Serializable
  attr_accessor :amount, :symbol


  def currency_format
    # <<~HTML
    #   <span>
    #     <span>#{symbol}</span>
    #     <span>#{amount}</span>
    #   </span>
    # HTML
    number_to_currency amount, unit: symbol, format: '%u %n'
  end
end
