# frozen_string_literal: true
require_relative '../entity/entity'
require_relative 'repository'
require 'json'

class LocalExchangeJsonRepository
  include ExchangeRepository

  # Fetches exchange rate data from a JSON file.
  def fetch_data

    map_currency_data = get_data_from_entity('data/eurofxref-hist-90d.json')

  end

  # method to retrieve and structure currency data from an entity (JSON file).
  private def get_data_from_entity(path)

    entity_src = Entity.new
    # Read the JSON file
    exchange_rates_data = entity_src.read_json_file(path)

    #Structure the data into a Map<String, {String, Map<String,float>}>
    #Map<Date, {conversion_source_currency, Map< curr_symbol , value>}>
    map_currency_data = entity_src.structure_data(exchange_rates_data)
    return map_currency_data

  end

end
