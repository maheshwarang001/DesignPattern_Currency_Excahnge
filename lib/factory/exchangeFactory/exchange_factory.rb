# frozen_string_literal: true
require_relative '../../exchange/local_exchange'
require_relative '../../utils/exchange_names'
require_relative '../../error/custom_error'


# Creates an instance of the specified exchange class
class ExchangeFactory
  include ExchangeNames


  def create_exchange_factory(exchange_class_name)

    case exchange_class_name
    when ExchangeNames::LOCAL_EXCHANGE
      LocalExchange.new
    else
      raise  CustomError::UnhandledError
    end
  end

end
