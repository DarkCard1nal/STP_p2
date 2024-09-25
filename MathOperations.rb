# frozen_string_literal: true

# Static class that defines mathematical operations and their priority receives operations from the specified file
class MathOperations
	# rubocop:disable Style/ClassVars
	@@MathOperations = %w[^ * / % + -]
	@@PrioritySticksOpen = %w'( ['
	@@PrioritySticksClose = %w') ]'
	# rubocop:enable Style/ClassVars

	def initialize
		raise NotImplementedError
	end

	def self.OperationPriority(input) # rubocop:disable Metrics/MethodLength
		index = @@MathOperations.index(input)
		if index.nil?
			index = @@PrioritySticksOpen.index(input)
			if index.nil?
				index = @@PrioritySticksClose.index(input)
				index = 0 if index.nil? == false
			else
				index = 1
			end
		else
			index += 2
		end

		index
	end
end
