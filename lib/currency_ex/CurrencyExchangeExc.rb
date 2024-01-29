require_relative 'currency_exchange'
require_relative '../factory/exchangeFactory/exchange_factory'
require_relative '../utils/exchange_names'
require_relative '../error/custom_error'
require 'date'


class CurrencyExchangeExc
  include CurrencyExchange

  def rate(date, from_currency, to_currency)

    start_time = Time.now

    # Input validation
    if  from_currency == nil || to_currency == nil || date == nil || from_currency.eql?(to_currency) || from_currency.length > 3 || to_currency.length > 3 || from_currency.empty? || to_currency.empty?
      raise CustomError::InputError
    end

    # Create an instance of ExchangeFactory
    exchange_factory = ExchangeFactory.new

    # Fetch exchange rate from the local exchange using ExchangeFactory
    local_exchange = exchange_factory
                       .create_exchange_factory(ExchangeNames::LOCAL_EXCHANGE)
                       .historic_exchange_rate(
                         date.strftime("%Y-%m-%d"),
                         from_currency.upcase,
                         to_currency.upcase,
                         "JSON",
                         ExchangeNames::LOCAL_EXCHANGE)

    # Log the exchange rate and execution time
    puts "#{from_currency} : #{local_exchange } #{to_currency}"
    puts "Total time taken: #{ Time.now - start_time }"

    return local_exchange



  end

end
