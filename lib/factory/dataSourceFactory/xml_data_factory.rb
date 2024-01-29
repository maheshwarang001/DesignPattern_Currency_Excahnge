# frozen_string_literal: true
require_relative 'abstract_data_factory'
require_relative '../../utils/exchange_names'
require_relative '../../error/custom_error'

# Creates an instance of the specified exchange repository class
class XmlDataFactory < AbstractDataFactory
  def get_data_source(exchange_name)
    case exchange_name

    when ExchangeNames::LOCAL_EXCHANGE
      raise CustomError::UnhandledError
    else
      raise CustomError::UnhandledError
    end
  end
end
