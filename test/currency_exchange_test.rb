# These are just suggested definitions to get you started.  Please feel
# free to make any changes at all as you see fit.


# http://test-unit.github.io/
require 'test/unit'
require_relative '../lib/currency_ex/CurrencyExchangeExc'
require_relative '../lib/entity/entity'
require 'date'
require_relative '../lib/error/custom_error'
require_relative '../lib/factory/exchangeFactory/exchange_factory'
require_relative '../lib/utils/exchange_names'
require_relative '../lib/exchange/local_exchange'
require_relative '../lib/factory/dataSourceFactory/data_factory_producer'
require_relative '../lib/factory/dataSourceFactory/json_data_factory'
require_relative '../lib/factory/dataSourceFactory/xml_data_factory'
require_relative '../lib/repository/local_exchange_json_repository'

class CurrencyExchangeTest < Test::Unit::TestCase
  def setup
  end



  def test_non_base_currency_exchange_is_correct
    correct_rate = 1.2870493690602498
    conversion = CurrencyExchangeExc.new
    assert_equal correct_rate,  conversion.rate(Date.new(2018,11,22), "GBP", "USD")
  end

  def test_base_currency_exchange_is_correct
    correct_rate = 0.007763975155279502
    conversion = CurrencyExchangeExc.new
    assert_equal correct_rate, conversion.rate(Date.new(2018,11,22), "JPY", "EUR")
  end

  def test_not_existing_currency_data
    conversion = CurrencyExchangeExc.new
    assert_raises CustomError::InputError do
      conversion.rate(Date.new(2018, 01, 22), "JPY", "EUR")
      end
  end

  def test_empty_from_to_data
    conversion = CurrencyExchangeExc.new
    assert_raises CustomError::InputError do
      conversion.rate(Date.new(2018, 01, 22), " ", "EUR")
    end
  end

  def test_empty_date
    conversion = CurrencyExchangeExc.new
    assert_raises CustomError::InputError do
      conversion.rate(nil, "GBP", "EUR")
    end
  end

  def test_nil_currency
    conversion = CurrencyExchangeExc.new
    assert_raises CustomError::InputError do
      conversion.rate(Date.new(2018, 01, 22), nil, nil)
    end
  end

  def test_method_returns_json
    entity = Entity.new
    data  = entity.read_json_file('data/eurofxref-hist-90d.json')
    assert_instance_of Hash, data

  end

  def test_method_file_not_exist
    entity = Entity.new
    assert_raises CustomError::FileNotFoundError do
      entity.read_json_file('/eurofxref-hist-90d.json')
    end
  end

  def test_method_json_not_exist
    entity = Entity.new
    assert_raises CustomError::InvalidJsonError do
      entity.read_json_file('lib/utils/exchange_names.rb')
    end
  end

  def test_method_invalid_data_form
    entity = Entity.new
    assert_raises CustomError::InvalidDataError do
      entity.structure_data("string")
    end
  end

  def test_exchange_factory_exchange_implemented
    factory = ExchangeFactory.new.create_exchange_factory(ExchangeNames::LOCAL_EXCHANGE)
    assert_instance_of(LocalExchange,factory)
  end

  def test_exchange_factory_exchange_not_implemented

    assert_raises CustomError::UnhandledError do
      ExchangeFactory.new.create_exchange_factory(ExchangeNames::EXCHANGE_A)
    end
  end

  def test_data_factory_producer_json
    data_factory = DataFactoryProducer.new.get_factory("JSON")
    assert_instance_of(JsonDataSourceFactory,data_factory)
  end

  def test_data_factory_producer_invalid_source
    assert_raises CustomError::UnhandledError do
      DataFactoryProducer.new.get_factory("DB")
    end
  end

  def test_exchange_repository_producer_json
    repo_factory = JsonDataSourceFactory.new.get_data_source(ExchangeNames::LOCAL_EXCHANGE)
    assert_instance_of(LocalExchangeJsonRepository,repo_factory)
  end

  def test_false_exchange_repository_producer_json
    assert_raises CustomError::UnhandledError do
      JsonDataSourceFactory.new.get_data_source(ExchangeNames::EXCHANGE_B)
    end
  end











end
