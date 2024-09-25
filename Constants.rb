# frozen_string_literal: true

module Constants
	AUTHOR = 'Converter of mathematical expressions to RPN form by Shkilnyi V. CS31'
	ENTER_INPUT = 'Enter a mathematical expression:'
	RESULT = 'Result of conversion to RPN:'
	FILE = 'MathOperations.txt'
	ERROR = 'ERROR!'
	STANDART_SET = 'The standard set of operations will be used for conversion!'
	FILE_NOT_FOUND = "#{ERROR} File not found. #{STANDART_SET}".freeze
	FILE_NOT_READABLE = "#{ERROR} File is not readable. #{STANDART_SET}".freeze
	FILE_BROKEN = "#{ERROR} The file structure is broken. #{STANDART_SET}".freeze
	INVALID_INPUT = "#{ERROR} Invalid input. Check that the input is correct!".freeze
end
