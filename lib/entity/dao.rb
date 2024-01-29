# frozen_string_literal: true
require_relative '../error/custom_error'
module DAO
  def read_json_file(file_path)
    raise CustomError::NotImplementedError
  end

  def structure_data(rate_data)
    raise CustomError::NotImplementedError
  end
end
