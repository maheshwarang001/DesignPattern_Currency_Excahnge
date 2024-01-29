# frozen_string_literal: true
require_relative 'exchange'
require_relative '../service/local_exchange_service'

class LocalExchange
  include Exchange

  def historic_exchange_rate(date, from_currency, to_currency, type, exchange_name)

    return LocalExchangeService.new.provide_data_to_historic(date,from_currency,to_currency,type,exchange_name)

  end

end
