# frozen_string_literal: true
require_relative '../error/custom_error'

module ExchangeRepository

  def fetch_data
    raise CustomError::NotImplementedError
  end

end
