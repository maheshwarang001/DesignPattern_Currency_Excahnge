# frozen_string_literal: true
require_relative '../singleton/singleton_local_exchange'
require_relative '../factory/dataSourceFactory/data_factory_producer'
require_relative '../utils/conversion_calculation'
require_relative '../error/custom_error'
require_relative '../utils/exchange_names'

# LocalExchangeService class handles currency conversion based on historic data.

class LocalExchangeService

  # Provides data for a specific historic date and performs currency conversion.
  def provide_data_to_historic(date, from_currency, to_currency, type, exchange_name)
    currency_data = get_currency_data(type, exchange_name)

    # Check if the requested date exists in the currency data
    raise CustomError::InputError unless currency_data.key?(date)

    src_currency = currency_data[date]['src']

    # Check if valid conversion can be performed based for base conversion
    if src_currency == from_currency && currency_data[date]['value'].key?(to_currency)
      return calculate_conversion(currency_data, date, from_currency, to_currency, src_currency)
    end
    # Check if src and to_currency are some
    if src_currency == to_currency
      return calculate_conversion(currency_data, date, from_currency, to_currency, src_currency)
    end

    # Raise error if input data is invalid
    raise CustomError::InputError if invalid_data?(currency_data, from_currency, to_currency, date)

    # Calculate conversion if all checks pass
    calculate_conversion(currency_data, date, from_currency, to_currency, src_currency)
  end



  # Private method to get currency data based on exchange type and name.
  private def get_currency_data(type, exchange_name)
    singleton_class = case exchange_name
                      when ExchangeNames::LOCAL_EXCHANGE
                        SingletonLocalExchange
                      else
                        raise CustomError::UnhandledError, "Unhandled exchange: #{exchange_name}"
                      end

    # Initialize singleton instance if it doesn't exist
    singleton_class.get_instance(get_repository(type, exchange_name)) unless singleton_class.instance_exists?

    exchange_data = singleton_class.get_instance.data

    # Raise error if exchange data is missing
    raise CustomError::UnhandledError if exchange_data.nil?

    # Display a message if the singleton instance was initiated
    puts "#{exchange_name.capitalize} Singleton was missing and initiated" unless singleton_class.instance_exists?

    return exchange_data
  end



  # Private method to get repository data based on type and exchange name.
  private def get_repository(type, exchange_name)
    DataFactoryProducer.new.get_factory(type).get_data_source(exchange_name).fetch_data
  end



  # Private method to check if input data is invalid.
  private def invalid_data?(currency_data, from_currency, to_currency, date)
    !currency_data[date]['value'].key?(from_currency) || !currency_data[date]['value'].key?(to_currency)
  end



  # Private method to calculate currency conversion using the Conversion_calculation class.
  private def calculate_conversion(currency_data, date, from_currency, to_currency, src_currency)
    ConversionCalculation.new.convert_a_to_b(
      currency_data[date]['value'][from_currency],
      currency_data[date]['value'][to_currency],
      from_currency,
      to_currency,
      src_currency
    )
  end


end
