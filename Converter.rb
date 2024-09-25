# frozen_string_literal: true

require_relative 'Constants'
require_relative 'MathOperations'

# Static abstract class that converts ordinary mathematical equations to RPN form
class Converter
	def initialize
		raise NotImplementedError
	end

	# The method takes an equation string with each character separated by a space and rotates as RNP
	def self.ConvertToRPN(input)
		MathOperations.UpdateMathOperationsFromFile(Constants::FILE)
		input = MathOperations.ReplaceWithSpaces(input)
		result = ''
		stack = []
		inputArr = input.split
		inputArr.each do |chr|
			result, stack = ConvertCharacter(result, stack, chr)
		end
		result += stack.reverse.join(' ')
		result.strip!

		result
	end

	# The method takes and processes the parts of the equation by character into the form RPN
	def self.ConvertCharacter(result, stack, chr)
		i = MathOperations.OperationPriority(chr)
		if i.nil?
			result += "#{chr} "
		elsif i >= 0
			result, stack = ConvertOperations(result, stack, chr, i)
		elsif i == -1
			stack.push('(')
		elsif i == -2
			result, stack = ConvertSticksClose(result, stack)
		end

		[result, stack]
	end

	def self.ConvertOperations(result, stack, chr, priority)
		result += "#{stack.pop} " unless stack.empty? || priority > MathOperations.OperationPriority(stack.last)
		stack.push(chr)

		[result, stack]
	end

	def self.ConvertSticksClose(result, stack)
		rindex = stack.rindex('(')
		unless rindex.nil?
			result += "#{stack[(rindex + 1)..].join(' ')} "
			stack = stack[0...rindex]
		end

		[result, stack]
	end

	private_class_method :ConvertCharacter
	private_class_method :ConvertOperations
	private_class_method :ConvertSticksClose
end
