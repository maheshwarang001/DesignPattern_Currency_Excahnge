# frozen_string_literal: true
require_relative 'json_data_factory'
require_relative 'xml_data_factory'
require_relative '../../error/custom_error'

# Creates an instance of the specified Data Source class
class DataFactoryProducer

  def get_factory(type)
    case type
    when "JSON"
      JsonDataSourceFactory.new
    when "XML"
      XmlDataFactory.new
    else
      raise CustomError::UnhandledError
    end
  end

end
