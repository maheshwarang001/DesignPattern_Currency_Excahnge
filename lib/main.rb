# frozen_string_literal: true
require_relative 'currency_ex/CurrencyExchangeExc'


loop do
  puts "Enter Date (YYYY-MM-DD) (or type 'exit' to quit): "
  user_date_input = gets.chomp

  break if user_date_input.downcase == "exit"

  begin
    user_date_input = Date.parse(user_date_input)
  rescue ArgumentError
    puts "Invalid Date format. Please enter a valid date in YYYY-MM-DD format."
    next
  end

  puts "Enter from currency:"
  user_from_currency = gets.chomp

  puts "Enter to currency:"
  user_to_currency = gets.chomp

  CurrencyExchangeExc.new.rate(user_date_input, user_from_currency, user_to_currency)

  puts ""
  puts ""

end
puts "Exiting the program."
