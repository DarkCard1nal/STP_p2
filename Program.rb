# frozen_string_literal: true

require_relative 'MathOperations'

puts('Converter of mathematical expressions to RPN form by Shkilnyi V. CS31')

MathOperations.UpdateMathOperationsFromFile(Constants::FILE)

puts(MathOperations.OperationPriority('-'))
puts(MathOperations.OperationPriority('^'))
puts(MathOperations.OperationPriority('['))
puts(MathOperations.OperationPriority(']'))
puts(MathOperations.OperationPriority('('))
puts(MathOperations.OperationPriority(')'))
puts(MathOperations.OperationPriority('a'))
