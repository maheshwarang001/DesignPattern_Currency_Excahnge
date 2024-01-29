# frozen_string_literal: true
require_relative '../error/custom_error'

module Exchange
  def self.historic_exchange_rate(date, from_currency, to_currency)
    raise CustomError::NotImplementedError
  end
end
