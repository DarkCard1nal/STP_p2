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

	def self.OperationPriority(input)
		MathOperations.UpdateMathOperationsFromFile(Constants::FILE)

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

	def self.UpdateMathOperationsFromFile(filePath)
		unless File.exist?(filePath)
			puts Constants::FILE_NOT_FOUND
			return
		end

		unless File.readable?(filePath)
			puts Constants::FILE_NOT_READABLE
			return
		end

		lines = File.readlines(filePath)
		if lines.length < 3
			puts Constants::FILE_BROKEN
			return
		end

		# rubocop:disable Style/ClassVars
		@@MathOperations = lines[0].split
		@@PrioritySticksOpen = lines[1].split
		@@PrioritySticksClose = lines[2].split
		# rubocop:enable Style/ClassVars
	end
end
