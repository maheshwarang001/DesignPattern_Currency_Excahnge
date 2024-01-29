# frozen_string_literal: true

module CustomError
  # custom_errors.rb
    class FileNotFoundError < StandardError
      def initialize(message = 'File not found')
        super(message)
      end
    end

    class InvalidJsonError < StandardError
      def initialize(message = 'Invalid JSON format')
        super(message)
      end
    end

  class InputError < StandardError
    def initialize(message = 'No Data found')
      super(message)
    end
  end

  class InvalidDataError < StandardError
    def initialize(message = 'Invalid Data format')
      super(message)
    end
  end

  class NotImplementedError < StandardError
    def initialize(message = 'Not Implemented')
      super(message)
    end
  end

    class UnhandledError < StandardError
      def initialize(message = 'An unexpected error occurred')
        super(message)
      end
    end

end
