# frozen_string_literal: true
require_relative '../error/custom_error'

# Class responsible for currency conversion calculations
class ConversionCalculation

  # Converts amount from one currency to another
  def convert_a_to_b(curr1, curr2, symbol_1, symbol_2, src)

    # Handling conversion from USD to EUR (src == EUR)
    if src == symbol_2
      return 1/curr1
    end

    # Handling conversion from EUR to USD (src == EUR)
    if src == symbol_1
      return curr2
    end

    # Handling conversion from USD to GBP
    input = curr2/curr1

    # Checking for invalid negative input
    if input < 0
      raise CustomError::UnhandledError
    end

    return input
  end

end