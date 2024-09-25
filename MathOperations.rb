# frozen_string_literal: true

require_relative 'Constants'

# Static class that defines mathematical operations and their priority receives operations from the specified file
class MathOperations
	# rubocop:disable Style/ClassVars
	@@MathOperations = [%w[+ -], %w[* / %], '^']
	@@PrioritySticksOpen = %w'( ['
	@@PrioritySticksClose = %w') ]'
	# rubocop:enable Style/ClassVars

	def initialize
		raise NotImplementedError
	end

	# The method determines the priority of the operation, where 0 is low priority (0 and above is the index in
	# the MathOperations array), if -1 is opening the wishbone, if -2 is closing the wishbone,
	# if it is an unknown operation it is nil
	def self.OperationPriority(input)
		index = @@PrioritySticksOpen.index(input)
		if index.nil?
			index = @@PrioritySticksClose.index(input)
			if index.nil?
				@@MathOperations.each_with_index do |array, indexx|
					return indexx if array.include?(input)
				end
			else
				index = -2
			end
		else
			index = -1
		end

		index
	end

	def self.ReplaceWithSpaces(input)
		input.gsub!(/\s+/, '')
		regex = Regexp.union(@@MathOperations.flatten + @@PrioritySticksOpen + @@PrioritySticksClose)

		input.gsub!(regex) do |chr|
			" #{chr} "
		end

		input.strip
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

		groups = lines[0].split(',').map(&:split)

		# rubocop:disable Style/ClassVars
		@@MathOperations = groups
		@@PrioritySticksOpen = lines[1].split
		@@PrioritySticksClose = lines[2].split
		# rubocop:enable Style/ClassVars
	end
end
