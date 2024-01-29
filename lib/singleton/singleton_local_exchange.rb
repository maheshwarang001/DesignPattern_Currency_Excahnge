# frozen_string_literal: true
require 'singleton'

# SingletonLocalExchange class ensures that only one instance of the class exists
class SingletonLocalExchange
  include Singleton

  # Attribute reader for the 'data' attribute
  attr_reader :data

  # Private method to initialize the SingletonLocalExchange instance with data
  private def initialize(data)
    @data = data
  end

  # method to get or create the instance of SingletonLocalExchange.
  # If an instance already exists it returns the existing instance otherwise, it creates a new instance
  def self.get_instance(data = nil)
    @instance ||= new(data)
  end

  # method to check if an instance of SingletonLocalExchange already exists
  # Returns true if an instance exists, otherwise returns false
  def self.instance_exists?
    !@instance.nil?
  end
end

