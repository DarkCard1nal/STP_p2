# frozen_string_literal: true

require_relative 'MathOperations'
require_relative 'Converter'

MathOperations.UpdateMathOperationsFromFile(Constants::FILE)

puts(MathOperations.OperationPriority('-'))
puts(MathOperations.OperationPriority('/'))
puts(MathOperations.OperationPriority('^'))
puts(MathOperations.OperationPriority('['))
puts(MathOperations.OperationPriority(']'))
puts(MathOperations.OperationPriority('('))
puts(MathOperations.OperationPriority(')'))
puts(MathOperations.OperationPriority('a'))

puts(Converter.ConvertToRPN('3 + 4 * 2 / ( 1 - 5 ) ^ 2'))
puts(Converter.ConvertToRPN('a + b * c'))
puts(Converter.ConvertToRPN('( a + b ) * ( c + d )'))
puts(Converter.ConvertToRPN('b * c + a'))
puts(Converter.ConvertToRPN('( a + t ) * ( b * ( a + c ) ) ^ ( c + d )'))
