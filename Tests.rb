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

arr = [['3 + 4 * 2 / ( 1 - 5 ) ^ 2', '3 4 2 * 1 5 - 2 ^ / +'],
							['a + b * c', 'a b c * +'],
							['( a + b ) * ( c + d )', 'a b + c d + *'],
							['b * c + a', 'b c * a +'],
							['( a + t ) * ( b * ( a + c ) ) ^ ( c + d )', 'a t + b a c + * c d + ^ *'],
							['( a + t ) * ( b * ( a + c ) ) ) ^ ( c + d )', 'a t + b a c + * c d + ^ *'],
							['-2 + 4', '-2 4 +'],
							['3-5+', '3 5 -'],
							['3+-5+', '3 -5 +'],
							['1/0', nil],
							['3.4+5.9', '3.4 5.9 +']]

arr.each do |test|
	result = Converter.ConvertToRPN(test[0])
	p test[0]
	p result
	puts("Result: #{result == test[1]}")
end
