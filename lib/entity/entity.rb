# frozen_string_literal: true

require_relative 'dao'
require_relative '../error/custom_error'

class Entity
  include DAO

  # Reads and parses JSON data from the specified file path
  def read_json_file(file_path)
    begin
      file_contents = File.read(file_path)
      return JSON.parse(file_contents)

    rescue Errno::ENOENT => e
      # Handle file not found error
      raise CustomError::FileNotFoundError, "File not found: #{file_path}"

    rescue JSON::ParserError => e
      # Handle invalid JSON format error
      raise CustomError::InvalidJsonError, "Invalid JSON format in file: #{file_path}"

    rescue => e
      # Handle unexpected errors
      raise CustomError::UnhandledError, "An unexpected error occurred: #{e.message}"

    end
  end

  #Structure the data into a Map<String, {String, Map<String,float>}>
  #Map<Date, {conversion_source_currency, Map< curr_symbol , value>}>
  def structure_data(rate_data)
    exchange_rates_map = {}

    # Iterate through the rate data
    begin
      rate_data.each do |date, currencies|
        exchange_rates_map[date] = {
          "src" => "EUR",
          "value" => {}
        }

        currencies.each do |currency, rate|
          exchange_rates_map[date]["value"][currency] = rate
        end
      end
    rescue
      raise CustomError::InvalidDataError
    end

    exchange_rates_map
  end



end


