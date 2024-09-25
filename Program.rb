# frozen_string_literal: true

require_relative 'Constants'
require_relative 'Converter'

if ARGV.empty?
	puts(Constants::AUTHOR)
	puts(Constants::ENTER_INPUT)
	input = gets.chomp
	puts(Constants::RESULT)
else
	input = ARGV.join
end

input.gsub!(/\s+/, '')

if input.nil?
	puts(Constants::INVALID_INPUT)
	return
end

puts(Converter.ConvertToRPN(input))
