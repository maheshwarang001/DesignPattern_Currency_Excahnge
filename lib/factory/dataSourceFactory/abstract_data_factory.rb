# frozen_string_literal: true
require_relative '../../error/custom_error'
class AbstractDataFactory

  def get_data_source(exchange_name)
    raise CustomError::NotImplementedError
  end

end
